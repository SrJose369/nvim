local M = {}

require("colors.java")

M.setup = function()
	local system_os = ""
	if vim.fn.has("wsl") == 1 then
		system_os = "win"
	elseif vim.fn.has("unix") == 1 then
		system_os = "linux"
	elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
		system_os = "win"
	else
		print("OS not found, defaulting to 'linux'")
		system_os = "linux"
	end
	-- Workspace per project
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspace/" .. project_name
	-- Mason install path
	local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
	local lombok = vim.fn.stdpath("data") .. "/mason/packages/lombok-nightly/lombok.jar"
	local jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
	local config_dir = jdtls_path .. "/config_" .. system_os
	-- Debug/test bundles (optional)
	local bundles = {
		vim.fn.glob( vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", 1),
	}
	vim.list_extend(bundles,
		vim.split(vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar", 1), "\n"))
	local extendedClientCapabilities = require("jdtls").extendedClientCapabilities
	extendedClientCapabilities.classFileContentsSupport = true
	local config = {
		cmd = {
			-- "/home/jose/.sdkman/candidates/java/21.0.8-tem/bin/java",
			"java",
			-- depends on if `java` is in your $PATH env variable and if it points to the right version.
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",
			-- "-javaagent:" .. lombok,
			"-jar",
			jar,
			-- "/home/jose/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar",
			"-configuration",
			config_dir,
			-- "/home/jose/.local/share/nvim/mason/packages/jdtls/config_linux",
			"-data",
			workspace_dir,
		},
		-- 💀
		-- This is the default if not provided, you can remove it. Or adjust as needed.
		-- One dedicated LSP server & client will be started per unique root_dir
		root_dir = vim.fs.dirname(vim.fs.find({ "mvnw", "gradlew", ".git" }, { upward = true })[1]) or vim.fn.getcwd(),
		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {
				-- TODO Replace this with the absolute path to your main java version (JDTLS requires JDK 21 or higher)
				-- home = "/usr/lib/jvm/java-21-openjdk-amd64",
				home = os.getenv("JAVA_HOME"),
				configuration = {
					updateBuildConfiguration = "interactive",
					-- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
					-- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
					runtimes = {
						{
							name = "JavaSE-1.8",
							path = "/usr/lib/jvm/java-8-openjdk-amd64",
						},
						{
							name = "JavaSE-11",
							path = "/usr/lib/jvm/java-11-openjdk-amd64",
						},
						{
							name = "JavaSE-17",
							path = "/usr/lib/jvm/java-17-openjdk-amd64",
						},
						{
							name = "JavaSE-19",
							path = "/usr/lib/jvm/java-19-openjdk-amd64",
						},
						{
							name = "JavaSE-21",
							path = "/usr/lib/jvm/java-21-openjdk-amd64",
						},
					},
				},
				format = {
					enabled = true,
					-- Formatting works by default, but you can refer to a specific file/URL if you choose
					-- settings = {
					--   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
					--   profile = "GoogleStyle",
					-- },
				},
				signatureHelp = { enabled = true },
				eclipse = {
					downloadSources = true,
				},
				maven = {
					downloadSources = true,
				},
				implementationsCodeLens = {
					enabled = true,
				},
				referencesCodeLens = {
					enabled = true,
				},
				references = {
					includeDecompiledSources = true,
				},
				saveActions = {
					organizeImports = false,
				},
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
						"com",
						"java",
						"javax",
						"org",
					},
				},
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStarThreshold = 9999,
					},
				},
				inlayHints = {
					parameterNames = {
						enabled = "all", -- literals, all, none
					},
				},
				codeGeneration = {
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
					},
					useBlocks = true,
				},
			},
		},
		-- Needed for auto-completion with method signatures and placeholders
		capabilities = require("cmp_nvim_lsp").default_capabilities(),
		flags = {
			allow_incremental_sync = true,
		},
		init_options = {
			-- References the bundles defined above to support Debugging and Unit Testing
			bundles = bundles,
			extendedClientCapabilities = extendedClientCapabilities,
		},
		-- Needed for debugging
		on_attach = function(client, bufnr)
			require("jdtls").setup_dap({ hotcodereplace = "auto" })
			require("jdtls.dap").setup_dap_main_class_configs()
		end,
	}
	require("jdtls").start_or_attach(config)
end

return M
