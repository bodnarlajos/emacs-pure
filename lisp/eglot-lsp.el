;; -*- lexical-binding: t -*-

(straight-use-package 'eglot)
(straight-use-package 'lsp-haskell)
(straight-use-package 'lsp-javascript-typescript)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(html-mode "node"
                           "/home/lbodnar/node_modules/@angular/language-server"
                           "--ngProbeLocations"
                           "/home/lbodnar/node_modules"
                           "--tsProbeLocations"
                           "/home/lbodnar/node_modules"
                           "--stdio")))

(provide 'eglot-lsp)
