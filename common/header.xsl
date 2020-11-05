<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<!-- 
 * header.xsl
 * This page is used to format the details of project listed in project.xml
 * This xsl is being called from header.html
-->
<xsl:output method="html"/>
<xsl:param name="js_param" />
<xsl:param name="js_param2" />

<xsl:template match="/project">
<xsl:if test="count(Composite_Report)=0">
	<xsl:apply-templates select="/project" mode="compare" />
</xsl:if>
<xsl:if test="not(count(Composite_Report)=0)">
	<xsl:apply-templates select="Composite_Report" />
</xsl:if>

</xsl:template>

<xsl:template match="/project" mode="compare" >
    <table class="PTPAGELET">

    <colgroup span="2">
    <col width="50%"></col>
    <col width="50%"></col>
    </colgroup>

	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="projname/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="projname"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
	    <td align="left" class="PTNAVBACKGROUND">
			<xsl:value-of select="toolsrel/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="toolsrel"/></b>
	    </td>
    </tr>

    <tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="sourcedb/@label"/> 	
		</td>
		<td>
			<b><xsl:value-of select="sourcedb"/></b>
		</td> 
    </tr>
    <tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
			<xsl:value-of select="sourcedate/@label"/> 		
		</td>
		<td>
			<!-- Date -->
		    <b><xsl:value-of select="sourcedate" /></b>
	    </td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
			<xsl:value-of select="targetdb/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="targetdb"/></b>
	    </td>
    </tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
			<xsl:value-of select="targetdate/@label" /> 
		</td>
		<td>
			<!-- Date -->
		    <b><xsl:value-of select="targetdate" /></b>
	    </td>
    </tr>
    <tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
			<xsl:value-of select="compareby/@label"/>
		</td>
        <td class="PTNAVBACKGROUND">
			<b><xsl:value-of select="compareby"/></b>
		</td>
    </tr>


    </table>
</xsl:template>

<xsl:template match="Composite_Report">
	<div id="header">
<xsl:if test="('composite'=$js_param2)">
<ul id="primary">
	<li><a href="header.html?objtype=COMPTEST848SRC?rpttype=compare" target="viewarea">Compare Report</a></li>
	<li><span>Composite Report</span></li>
</ul>
</xsl:if>
<xsl:if test="('compare'=$js_param2)">
<ul id="primary">
	<li><span>Compare Report</span></li>
	<li><a href="header.html?objtype=COMPTEST848SRC?rpttype=composite" target="viewarea"><xsl:value-of select="./@label"/></a></li>
</ul>
</xsl:if>
</div>

<xsl:if test="('compare'=$js_param2)">
	<xsl:apply-templates select="/project" mode="compare" />
</xsl:if>
<xsl:if test="('composite'=$js_param2)">
	<xsl:apply-templates select="/project/Composite_Report" mode="composite" />
</xsl:if>
</xsl:template>

<xsl:template match="Composite_Report" mode="composite">
   <table class="PTPAGELET">

    <colgroup span="2">
    <col width="50%"></col>
    <col width="50%"></col>
    </colgroup>

	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="projname/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="projname"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="oldtoolsrel/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="oldtoolsrel"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="newtoolsrel/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="newtoolsrel"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="oldreldb/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="oldreldb"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="oldreldate/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="oldreldate"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="newreldb/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="newreldb"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="newreldate/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="newreldate"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="custdb/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="custdb"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
		    <xsl:value-of select="custdate/@label"/>
		</td>
		<td>
			<b><xsl:value-of select="custdate"/></b>
		</td>
	</tr>
	<tr class="PTNAVBACKGROUND">
		<td align="left" class="PTNAVBACKGROUND">
			<xsl:value-of select="/project/compareby/@label"/>
		</td>
        <td class="PTNAVBACKGROUND">
		<b><xsl:value-of select="/project/compareby"/></b>
		</td>
    </tr>
    </table>

</xsl:template>

<!-- EOF -->
</xsl:stylesheet>
