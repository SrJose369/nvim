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
	instance_final_field = "#dcdc1a",
}

local function hi(group, spec) vim.api.nvim_set_hl(0, group, spec) end

hi("@keyword.import.java", {fg = P.keyword})
hi("@keyword.operator.java", {fg = P.keyword})
hi("@keyword.type.java", {fg = P.keyword})

hi("@lsp.type.modifier.java", {fg = P.keyword})
hi("@type.builtin.java", {fg = P.keyword})
hi("@variable.builtin.java", {fg = P.keyword})
hi("@constant.builtin.java", {fg = P.keyword})

hi("@keyword.exception.java", {fg = P.keyword})
hi("@keyword.conditional.java", {fg = P.keyword})

hi("@number.java", {fg = P.number})
hi("@string.java", {fg = P.string})
hi("@boolean.java", {fg = P.keyword})

hi("@constructor.java", {fg = P.method_decl})
hi("@lsp.type.class.java", {fg = P.class})
hi("@lsp.typemod.class.public.java", {fg = P.class})
hi("@lsp.mod.importDeclaration.java", {fg = P.class})
hi("@lsp.type.namespace.java", {fg = P.class})

hi("@lsp.typemod.interface.importDeclaration.java", {fg = P.interface})
hi("@lsp.type.interface.java", {fg = P.interface})

hi("@lsp.type.enum.java", {fg = P.enum})
hi("@lsp.typemod.enum.public.java", {fg = P.enum, italic = false})
hi("@lsp.typemod.enumMember.public.java", {fg = P.instance_field, italic = true, bold = true})

hi("@lsp.typemod.method.declaration.java", {fg = P.method_decl})
hi("@lsp.type.method.java", {fg = P.method_call})

-- hi("@lsp.typemod.method.static.java", {fg = "#a6b4c4", italic = true})
hi("@lsp.mod.static.java", {fg = "#a6b4c4", italic = true})

hi("@lsp.type.annotation.java", {fg = "#bbb529"})
hi("@attribute.java", {fg = "#bbb529"})
hi("@operator.java", {fg = P.operator})

hi("@comment.documentation.java", {fg = P.doc_comment})
hi("@lsp.mod.documentation.java", {fg = P.doc_comment})
hi("@lsp.typemod.keyword.documentation.java", {fg = P.doc_comment, bold = true, italic = true, underline = true})
hi("@lsp.typemod.parameter.documentation.java", {fg = "#8a653b"})

hi("@lsp.type.variable.java", {fg = P.local_variable})
hi("@lsp.type.parameter.java", {fg = P.parameter})

hi("@lsp.type.property.java", {fg = P.instance_field})
-- hi("@lsp.mod.readonly.java", {fg = P.instance_field, bold = true})
hi("@lsp.typemod.property.readonly.java", {bold = true})
hi("@lsp.typemod.property.static.java", {fg = P.instance_field})

-- hi("@static.final.var.java", {fg = P.instance_field, bold = true, italic = true})

-- Tag value #8a653b
-- Visual #214283
-- Indentifier under caret #344134
