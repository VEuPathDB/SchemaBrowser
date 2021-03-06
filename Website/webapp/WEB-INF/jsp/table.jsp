<%! String base = ""; %>
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<b><big><a href="tableList.htm">GUS Schema</a> >> ${table.schema.name}::${table.name}</b></big>

<c:if test='${not empty table.superclass}'>
		(subclass of <a href="table.htm?schema=${table.superclass.schema.name}&table=${table.superclass.name}">
			${table.superclass.schema.name}::${table.superclass.name}
		</a>)</TD>
		</c:if>
</FONT>


<p>

<p><strong>Category: </strong><a href="categoryList.htm#sc:${table.category.superCategory.name}">${table.category.superCategory.name}</a>::
	   <a href="categoryList.htm#c:${table.category.name}">${table.category.name}</a><br/>
   <strong>Documentation: </strong>${table.documentation}
	<small><a href="edit/edit.htm?schema=${table.schema.name}&table=${table.name}">Edit</a></small>
</p>

<c:if test='${not empty table.superclass}'>
	<p><small>Light blue rows indicate columns provided from the superclass.</small></p>
</c:if>


<table id="tableDisplay">
	<tr class="tableRow">
		<td class="columnHead">column</td>
		<td class="columnHead">nulls?</td>
		<td class="columnHead">type</td>
		<td class="columnHead">description</td>
	</tr>

<c:if test='${not empty table.superclass}'>

	<c:set var="table" value="${table}"/>
	<jsp:useBean id="table" type="org.gusdb.dbadmin.model.Table"/>
	<% pageContext.setAttribute("columns", table.getSuperclass().getColumns(false) ); %>

	<c:forEach items="${columns}" var="column">
		<sb:WriteAttributeRow column="${column}" fromSuperclass="true"/>
	</c:forEach>
</c:if>

<c:forEach items="${table.columns}" var="column">
	<sb:WriteAttributeRow column="${column}"/>
</c:forEach>

</table>
<p/>
<FONT FACE="helvetica, sans-serif"><B>Child tables:</B></FONT><p/>
	<sb:WriteChildren table="${table}"/>
<p/>

<FONT FACE="helvetica, sans-serif"><B>Subclasses:</B></FONT><p/>

<c:forEach items="${table.subclasses}" var="subclass">
	<a href="table.htm?schema=${subclass.schema.name}&table=${subclass.name}">
		${subclass.schema.name}::${subclass.name}
	</a> <br/>
</c:forEach>

<%@ include file="/WEB-INF/jsp/footer.jsp" %>
