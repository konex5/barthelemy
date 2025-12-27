{ emacsPackagesFor
, emacs-nox
, lib
, runCommand
, stdenv
, symlinkJoin
, writeText
, cppSupport ? false
, latexSupport ? false
, haskellSupport ? false
, pythonSupport ? false
}:

let
  emacs-noxExt =
    let
      myEmacsConfig = writeText "default.el" (''
        ;; initialize package
        (eval-when-compile
          (require 'use-package)) ;; better than straight.el
        (require 'diminish) ;; if you use :diminish
        (require 'bind-key) ;; if you use :bind
        (setq package-enable-at-startup nil) ;; make sure package.el is not used
        (setq use-package-ensure-function 'ignore)
        (setq package-archives nil)
        ;; theme
        (menu-bar-mode -1) ;; disable menu bar
        (global-display-line-numbers-mode)
        (use-package beacon
          :init (beacon-mode 1))
        (use-package zerodark-theme
          :init (load-theme 'zerodark t) (zerodark-setup-modeline-format))
        ;; ui        
        (use-package company ;; auto-complete
          :bind ("<C-tab>" . company-complete)
          :diminish company-mode
          :commands (company-mode global-company-mode)
          :defer 1
          :config
          (global-company-mode))
        (use-package vertico ;; the search engine
          :defer 1
          :init (vertico-mode)
          :config
          (setq vertico-scroll-margin 0) ;; different margin
          (setq vertico-resize t) ;; grow/shring minibuffer
          (setq vertico-cycle t) ;; enable cycling
          )
        (use-package orderless ;; better search
          :init
          (setq completion-styles '(orderless basic)
                completion-category-defaults nil
                completion-category-overrides '((file (styles partial-completion)))))
        (use-package marginalia ;; annotations
          :init (marginalia-mode))
        (use-package saveplace ;; save cursor position
          :init (save-place-mode))
        (use-package savehist ;; cmd history
          :init (savehist-mode))
        (use-package undo-fu ;; add a redo command
          :config
          (global-unset-key (kbd "C-z"))
          (global-set-key (kbd "C-z")   'undo-fu-only-undo)
          (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))
        (use-package undo-fu-session ;; undo between sessions
          :config
          (setq undo-fu-session-incompatible-files '("/COMMIT_EDITMSG\\'" "/git-rebase-todo\\'")))
        (global-undo-fu-session-mode)
        (use-package which-key ;; annotations
          :diminish which-key-mode
          :config (which-key-mode))
        (use-package swiper ;; search in file
          :bind (("C-s" . swiper-isearch)
                 ("C-r" . swiper-isearch-backward))
          :diminish swiper)
        ;; packages
        (use-package flycheck ;; spell properly
          :defer 2
          :diminish flycheck-mode
          :config (global-flycheck-mode))
        (use-package magit ;; porcelaine
          :defer 2
          :if (executable-find "git")
          :bind (("C-x g" . magit-status)
                 ("C-x G" . magit-dispatch))
          :init
          (setq magit-completing-read-function 'ivy-completing-read))
        (use-package git-gutter ;; git diff HEAD
          :diminish git-gutter-mode
          :config (global-git-gutter-mode))
      '' + lib.optionalString (haskellSupport) ''
        ;; dante
        (use-package dante
          :ensure t
          :after haskell-mode
          :commands 'dante-mode
          :init
          (add-hook 'haskell-mode-hook 'flycheck-mode)
          ;; OR for flymake support:
          (add-hook 'haskell-mode-hook 'flymake-mode)
          (remove-hook 'flymake-diagnostic-functions 'flymake-proc-legacy-flymake)        
          (add-hook 'haskell-mode-hook 'dante-mode)
          )
      '');
      overrides = self: super: rec {
        myEmacsDefaultEl = (runCommand "default.el" { } ''
          mkdir -p $out/share/emacs/site-lisp
          cp ${myEmacsConfig} $out/share/emacs/site-lisp/default.el
        '');
      };
    in
    ((emacsPackagesFor emacs-nox).overrideScope' overrides).withPackages
      (p: with p; [
        use-package
        diminish
        bind-key
        myEmacsDefaultEl
        nameless
        # ;; themes
        beacon
        zerodark-theme
        # ;; ui
        company
        git-gutter
        marginalia
        orderless
        vertico
        which-key
        # ;; packages
        consult
        consult-flycheck
        consult-company
        embark
        embark-consult
        wgrep
        swiper
        undo-fu
        undo-fu-session
        # ;; more packages
        flycheck
        magit
      ] ++ lib.optionals (cppSupport) [ ] ++
      lib.optionals (latexSupport) [ auctex ] ++
      lib.optionals (haskellSupport) [ dante haskell-mode haskell-snippets ] ++
      lib.optionals (pythonSupport) [ python-mode ] ++
      [ markdown-mode nix-mode ]);

in
symlinkJoin {
  name = "konex-config-emacs" + lib.optionalString (cppSupport) "-with-c"
    + lib.optionalString (latexSupport) "-with-latex"
    + lib.optionalString (haskellSupport) "-with-hs"
    + lib.optionalString (pythonSupport) "-with-py";
  paths = [ emacs-noxExt ];
  postBuild = "echo emacs in one destination";
}
