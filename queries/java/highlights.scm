; extends
((constructor_declaration
   name: (identifier) @constructor)
 (#set! priority 130))

(field_declaration
  (modifiers
	"static"
	"final")
  declarator: (variable_declarator
				name: (identifier) @static.final.var))
