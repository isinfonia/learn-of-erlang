-module(boolean).
-compile(export_all).

b_not(Bool1) ->
	not Bool1.
b_and(Bool2, Bool3) ->
	Bool2 and Bool3.
b_or(Bool4, Bool5) ->
	Bool4 or Bool5.
b_nand(Bool6, Bool7) ->
	b_not(b_and(Bool6, Bool7)).
