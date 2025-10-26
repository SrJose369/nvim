local P = {
	bg                   = "#282a36",
	fg                   = "#a9b7c6",
	class                = "#e7008b",
	abstract             = "#31699d",
	anon_class           = "#31699d",
	interface            = "#2bf8d3",
	enum                 = "#fd773f",
	type_param           = "#ff783e",
	doc_comment          = "#629755",
	keyword              = "#ca4fff",
	number               = "#fcb547",
	operator             = "#c2662f",
	semicolon            = "#e6e6e6",
	string               = "#0eb9d1",
	string_escape        = "#fd773f",
	lambda_param         = "#376bf8",
	local_variable       = "#009933",
	method_call          = "#fa44c4",
	method_decl          = "#fcb547",
	default_fn_call      = "#31699d",
	parameter            = "#2e65f6",
	reassigned_param     = "#376bf8",
	instance_field       = "#9876aa",
	instance_final_field = "#fffb19",
}

local function hi(group, spec) vim.api.nvim_set_hl(0, group, spec) end

hi("@keyword.import.typescript", {fg = P.keyword})
hi("@keyword.operator.typescript", {fg = P.keyword})
hi("@keyword.type.typescript", {fg = P.keyword})
hi("@keyword.typescript", {fg = P.keyword})
hi("@keyword.function.typescript", {fg = P.keyword})
hi("@keyword.coroutine.typescript", {fg = P.keyword})
hi("@keyword.modifier.typescript", {fg = P.keyword})
hi("@keyword.return.typescript", {fg = P.keyword})
--
-- hi("@constructor.typescript", {fg = P.keyword})
hi("@constant.builtin.typescript", {fg = P.keyword})
hi("@type.builtin.typescript", {fg = P.enum})
-- hi("@variable.builtin.typescript", {fg = P.method_call})

hi("@keyword.exception.typescript", {fg = P.keyword})
hi("@keyword.conditional.typescript", {fg = P.keyword})
hi("@keyword.repeat.typescript", {fg = P.keyword})

hi("@number.typescript", {fg = P.number})
hi("@string.typescript", {fg = P.string})
hi("@boolean.typescript", {fg = P.keyword})

hi("@lsp.type.type.typescript", {fg = P.interface})
hi("@lsp.type.property.typescript", {fg = P.instance_field})
hi("@lsp.type.class.typescript", {fg = P.class})
hi("@type.typescript", {fg = P.class})

hi("@lsp.type.enum.typescript", {fg = P.enum})
hi("@lsp.type.enumMember.typescript", {fg = P.instance_field, bold = true})

hi("@lsp.type.interface.typescript", {fg = P.interface})


hi("@lsp.type.fcunction.typescript", {fg = P.method_call})
hi("@lsp.type.function.typescript", {fg = P.method_decl})
hi("@lsp.type.member.typescript", {fg = P.method_decl})
hi("@lsp.type.namespace.typescript", {fg = "#a6b4c4"})
hi("@lstp.typemod.member.declaration.typescript", {fg = P.method_decl})
hi("@lsp.typemod.member.defaultLibrary.typescript", {fg = P.method_decl})

hi("@operator.typescript", {fg = P.operator})

hi("@comment.documentation.typescript", {fg = P.doc_comment})

hi("@lsp.typemod.variable.defaultLibrary.typescript", {fg = P.method_call})
hi("@lsp.type.variable.typescript", {fg = P.method_call})
hi("@lsp.type.parameter.typescript", {fg = P.parameter})
hi("@lsp.mod.local.typescript", {fg = P.local_variable})

-- Tag value #8a653b
-- Visual #214283
-- Indentifier under caret #344134
