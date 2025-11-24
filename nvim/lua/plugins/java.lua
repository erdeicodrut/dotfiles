return {
  -- Java/Android LSP (jdtls) via nvim-jdtls
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
    config = function()
      local jdtls = require("jdtls")
      local mason_registry = require("mason-registry")

      -- Detect Android SDK path
      local function get_android_sdk()
        local sdk = os.getenv("ANDROID_HOME") or os.getenv("ANDROID_SDK_ROOT")
        if not sdk then
          local default_paths = {
            vim.fn.expand("~/Library/Android/sdk"), -- macOS default
            vim.fn.expand("~/Android/Sdk"), -- Linux default
          }
          for _, path in ipairs(default_paths) do
            if vim.fn.isdirectory(path) == 1 then
              sdk = path
              break
            end
          end
        end
        return sdk
      end

      local function get_jdtls_paths()
        -- Ensure registry is ready
        if not mason_registry.has_package("jdtls") then
          mason_registry.refresh()
        end

        local ok, jdtls_pkg = pcall(mason_registry.get_package, "jdtls")
        if not ok or not jdtls_pkg:is_installed() then
          vim.notify("jdtls is not installed. Run :MasonInstall jdtls", vim.log.levels.WARN)
          return nil
        end

        local jdtls_path = jdtls_pkg:get_install_path()
        local launcher = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
        local config_dir = jdtls_path .. "/config_mac"
        if vim.fn.has("linux") == 1 then
          config_dir = jdtls_path .. "/config_linux"
        end
        return {
          launcher = launcher,
          config_dir = config_dir,
        }
      end

      local function jdtls_setup()
        local paths = get_jdtls_paths()
        if not paths then
          return
        end

        -- Android + standard Java project markers
        local root_markers = {
          "settings.gradle",
          "settings.gradle.kts",
          "build.gradle",
          "build.gradle.kts",
          "pom.xml",
          "mvnw",
          "gradlew",
          ".git",
        }
        local root_dir = require("jdtls.setup").find_root(root_markers) or vim.fn.getcwd()
        local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
        local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name

        local android_sdk = get_android_sdk()
        local extendedClientCapabilities = jdtls.extendedClientCapabilities
        extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

        local config = {
          cmd = {
            "java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-Xmx2g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-jar", paths.launcher,
            "-configuration", paths.config_dir,
            "-data", workspace_dir,
          },
          root_dir = root_dir,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          init_options = {
            extendedClientCapabilities = extendedClientCapabilities,
          },
          settings = {
            java = {
              inlayHints = { parameterNames = { enabled = "none" } },
              signatureHelp = { enabled = true },
              completion = {
                favoriteStaticMembers = {
                  "org.hamcrest.MatcherAssert.assertThat",
                  "org.hamcrest.Matchers.*",
                  "org.hamcrest.CoreMatchers.*",
                  "org.junit.jupiter.api.Assertions.*",
                  "java.util.Objects.requireNonNull",
                  "java.util.Objects.requireNonNullElse",
                  "org.mockito.Mockito.*",
                },
                importOrder = {
                  "android",
                  "androidx",
                  "com",
                  "org",
                  "java",
                  "javax",
                },
              },
              sources = {
                organizeImports = {
                  starThreshold = 9999,
                  staticStarThreshold = 9999,
                },
              },
              configuration = {
                runtimes = android_sdk and {
                  {
                    name = "JavaSE-17",
                    path = vim.fn.expand("$JAVA_HOME"),
                    default = true,
                  },
                } or nil,
              },
              import = {
                gradle = { enabled = true },
                maven = { enabled = true },
              },
              eclipse = { downloadSources = true },
              maven = { downloadSources = true },
              project = {
                referencedLibraries = android_sdk and {
                  android_sdk .. "/platforms/android-*/android.jar",
                } or {},
              },
            },
          },
        }

        -- Notify about Android SDK status
        if android_sdk then
          vim.notify("Android SDK found: " .. android_sdk, vim.log.levels.INFO)
        end

        jdtls.start_or_attach(config)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = jdtls_setup,
      })
    end,
  },

  -- Ensure mason installs jdtls
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = { "jdtls" },
    },
  },

  -- Android development workflow (build, install, run, logcat)
  {
    "rrxxyz/droid-nvim",
    ft = { "java", "kotlin", "xml" },
    cmd = { "DroidRun", "DroidBuildDebug", "DroidInstall", "DroidDevices", "DroidEmulator", "DroidTask" },
    config = function()
      require("droid").setup({
        -- Logcat window layout: "horizontal", "vertical", or "float"
        logcat_mode = "horizontal",
        -- Auto-launch app after install
        auto_launch = true,
        -- Filter logcat to your app's package
        filter_package = "mine",
      })
    end,
  },
}
