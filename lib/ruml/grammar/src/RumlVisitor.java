// Generated from Ruml.g4 by ANTLR 4.5
import org.antlr.v4.runtime.misc.NotNull;
import org.antlr.v4.runtime.tree.ParseTreeVisitor;

/**
 * This interface defines a complete generic visitor for a parse tree produced
 * by {@link RumlParser}.
 *
 * @param <T> The return type of the visit operation. Use {@link Void} for
 * operations with no return type.
 */
public interface RumlVisitor<T> extends ParseTreeVisitor<T> {
	/**
	 * Visit a parse tree produced by {@link RumlParser#ruml}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitRuml(RumlParser.RumlContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#module_def}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitModule_def(RumlParser.Module_defContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#module_name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitModule_name(RumlParser.Module_nameContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#class_def}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitClass_def(RumlParser.Class_defContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#class_name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitClass_name(RumlParser.Class_nameContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#super_class_name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSuper_class_name(RumlParser.Super_class_nameContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#body}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitBody(RumlParser.BodyContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#include_def}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInclude_def(RumlParser.Include_defContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#extend_def}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitExtend_def(RumlParser.Extend_defContext ctx);
	/**
	 * Visit a parse tree produced by the {@code attr_reader}
	 * labeled alternative in {@link RumlParser#attributes_def}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAttr_reader(RumlParser.Attr_readerContext ctx);
	/**
	 * Visit a parse tree produced by the {@code attr_writter}
	 * labeled alternative in {@link RumlParser#attributes_def}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAttr_writter(RumlParser.Attr_writterContext ctx);
	/**
	 * Visit a parse tree produced by the {@code attr_accessor}
	 * labeled alternative in {@link RumlParser#attributes_def}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitAttr_accessor(RumlParser.Attr_accessorContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#class_method_def}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitClass_method_def(RumlParser.Class_method_defContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#class_method_name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitClass_method_name(RumlParser.Class_method_nameContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#instance_method_def}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInstance_method_def(RumlParser.Instance_method_defContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#instance_method_name}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitInstance_method_name(RumlParser.Instance_method_nameContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#params}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParams(RumlParser.ParamsContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#param}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitParam(RumlParser.ParamContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#normal_param}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNormal_param(RumlParser.Normal_paramContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#keyword_param}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitKeyword_param(RumlParser.Keyword_paramContext ctx);
	/**
	 * Visit a parse tree produced by {@link RumlParser#default_param}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitDefault_param(RumlParser.Default_paramContext ctx);
	/**
	 * Visit a parse tree produced by the {@code stringValue}
	 * labeled alternative in {@link RumlParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitStringValue(RumlParser.StringValueContext ctx);
	/**
	 * Visit a parse tree produced by the {@code symbolValue}
	 * labeled alternative in {@link RumlParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitSymbolValue(RumlParser.SymbolValueContext ctx);
	/**
	 * Visit a parse tree produced by the {@code numberValue}
	 * labeled alternative in {@link RumlParser#value}.
	 * @param ctx the parse tree
	 * @return the visitor result
	 */
	T visitNumberValue(RumlParser.NumberValueContext ctx);
}