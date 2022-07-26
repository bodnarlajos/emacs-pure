;; -*- lexical-binding: t -*-
(require 'dap-mode)
(require 'dap-utils)

(dap-mode 1)
(dap-ui-mode 1)
(dap-tooltip-mode 1)
(tooltip-mode 1)
;; (setq debug-on-error t)

(dap-register-debug-provider
 "hda"
 (lambda (conf)
   (plist-put conf :dap-server-path (list "haskell-debug-adapter" "--hackage-version=0.0.31.0"))
   conf))

(dap-register-debug-template "haskell-debug-adapter-withMVarTest"
														 (list :type "hda"
																	 :request "launch"
																	 :name "haskell-debug-adapter"
																	 :internalConsoleOptions "openOnSessionStart"
																	 ;; :workspace (lsp-find-session-folder (lsp-session) (buffer-file-name))
																	 :workspace "/home/lbodnar/Projects/WithMVarTest"
																	 :startup "/home/lbodnar/Projects/WithMVarTest/app/Main.hs"
																	 :startupFunc ""
																	 :startupArgs ""
																	 :stopOnEntry t
																	 :mainArgs ""
																	 :ghciPrompt "H>>= "
																	 :ghciInitialPrompt "Prelude>"
																	 :ghciCmd "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show"
																	 :ghciEnv (list :dummy "")
																	 :logFile "/home/lbodnar/Projects/WithMVarTest/hdx4emacs.log"
																	 :logLevel "WARNING"
																	 :forceInspect nil))

(dap-register-debug-template "haskell-debug-adapter-webmail2"
														 (list :type "hda"
																	 :request "launch"
																	 :name "haskell-debug-adapter"
																	 :internalConsoleOptions "openOnSessionStart"
																	 ;; :workspace (lsp-find-session-folder (lsp-session) (buffer-file-name))
																	 :workspace "/home/lbodnar/Projects/webmail2"
																	 :startup "/home/lbodnar/Projects/webmail2/app/main.hs"
																	 :startupFunc ""
																	 :startupArgs ""
																	 :stopOnEntry t
																	 :mainArgs ""
																	 :ghciPrompt "H>>= "
																	 :ghciInitialPrompt "Prelude>"
																	 :ghciCmd "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show"
																	 :ghciEnv (list :dummy "")
																	 :logFile "/home/lbodnar/Projects/webmail2/hdx4emacs.log"
																	 :logLevel "WARNING"
																	 :forceInspect nil))

(dap-register-debug-template "haskell-debug-adapter-yesod"
														 (list :type "hda"
																	 :request "launch"
																	 :name "haskell-debug-adapter"
																	 :internalConsoleOptions "openOnSessionStart"
																	 ;; :workspace (lsp-find-session-folder (lsp-session) (buffer-file-name))
																	 :workspace "/home/lbodnar/Projects/yesod-test1"
																	 :startup "/home/lbodnar/Projects/yesod-test1/app/main.hs"
																	 :startupFunc ""
																	 :startupArgs ""
																	 :stopOnEntry t
																	 :mainArgs ""
																	 :ghciPrompt "H>>= "
																	 :ghciInitialPrompt "Prelude>"
																	 :ghciCmd "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show"
																	 :ghciEnv (list :dummy "")
																	 :logFile "/home/lbodnar/Projects/yesod-test1/haskell-debug.log"
																	 :logLevel "WARNING"
																	 :forceInspect nil))

(dap-register-debug-template "haskell-debug-adapter-easyregistration"
														 (list :type "hda"
																	 :request "launch"
																	 :name "haskell-debug-adapter"
																	 :internalConsoleOptions "openOnSessionStart"
																	 ;; :workspace (lsp-find-session-folder (lsp-session) (buffer-file-name))
																	 :workspace "/home/lbodnar/Projects/easyregistration"
																	 :startup "/home/lbodnar/Projects/easyregistration/app/main.hs"
																	 :startupFunc ""
																	 :startupArgs ""
																	 :stopOnEntry t
																	 :mainArgs ""
																	 :ghciPrompt "H>>= "
																	 :ghciInitialPrompt "Prelude>"
																	 :ghciCmd "stack ghci --test --no-load --no-build --main-is TARGET --ghci-options -fprint-evld-with-show"
																	 :ghciEnv (list :dummy "")
																	 :logFile "/home/lbodnar/Projects/easyregistration/hdx4emacs.log"
																	 :logLevel "WARNING"
																	 :forceInspect nil))
