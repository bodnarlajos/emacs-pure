;; -*- lexical-binding: t -*-

(straight-use-package 'lsp-haskell)
(straight-use-package 'lsp-javascript-typescript)
(straight-use-package 'consult-lsp)
(setq completion-category-overrides '((eglot (styles . (orderless flex)))))
(with-eval-after-load 'eglot
  (add-hook 'eglot-managed-mode-hook
          (lambda ()
            ;; Show flymake diagnostics first.
            (setq eldoc-documentation-functions
                  (cons #'flymake-eldoc-function
                        (remove #'flymake-eldoc-function eldoc-documentation-functions)))
            ;; Show all eldoc feedback.
            (setq eldoc-documentation-strategy #'eldoc-documentation-compose)))
  (add-to-list 'eglot-server-programs
               '(web-mode "node"
                          "/home/lbodnar/node_modules/@angular/language-server"
                          "--ngProbeLocations"
                          "/home/lbodnar/node_modules"
                          "--tsProbeLocations"
                          "/home/lbodnar/node_modules"
                          "--stdio"))
  (add-to-list 'eglot-server-programs
               '(html-mode "node"
                           "/home/lbodnar/node_modules/@angular/language-server"
                           "--ngProbeLocations"
                           "/home/lbodnar/node_modules"
                           "--tsProbeLocations"
                           "/home/lbodnar/node_modules"
                           "--stdio"))
  (add-to-list 'eglot-server-programs
               `(csharp-mode . ("/home/lbodnar/Projects/omnisharp-roslyn/OmniSharp" "-lsp"))))

(provide 'eglot-lsp)
