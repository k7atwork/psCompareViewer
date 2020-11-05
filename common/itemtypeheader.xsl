<?xml version='1.0'?>
<!-- 
 * itemtypeheader.xsl
 * This page is used to introduce the paging on the grid header 
 * This xsl is being called from viewarea.html
 * It expects 3 parameters from the JS method 
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="html"/>
<xsl:param name="js_param1"/>
<xsl:param name="js_param2"/>
<xsl:param name="js_param3"/>
<xsl:param name="js_param4"/>

<xsl:template match="/">

  <xsl:apply-templates select="/project/object_type" mode="keylist" />

</xsl:template>

<!-- Object names per type, mode = "keylist" -->

 <xsl:template match="/project/object_type" mode="keylist">
 <xsl:variable name="objtypename" select="@name"/>
 <xsl:variable name="constantone" select='1'/>
 <xsl:variable name="firstpage" select = "concat($objtypename,'_',$constantone)"/>
 <xsl:variable name="previouspage" select = "concat($objtypename,'_',$js_param1 - $constantone)"/>
 <xsl:variable name="nextpage" select = "concat($objtypename,'_',$js_param1 + $constantone)"/>
 <xsl:variable name="lastpage" select = "concat($objtypename,'_',$js_param3)"/>
 <xsl:variable name="nextpagenumber" select = "$js_param1 + $constantone"/>
 <xsl:variable name="previouspagenumber" select = "$js_param1 - $constantone"/>
 <xsl:variable name="firstitem" select="@firstitem"/>
 <xsl:variable name="lastitem" select="@firstitem + @items - $constantone"/>
 
 <!-- Object Type Name table -->
<table border="0" cellspacing="0" cellpadding="1" cols="1" width="100%" class="PSLEVEL1GRID">

    <tr class="PSLEVEL1GRIDLABEL" valign="bottom"> 
        <td align="left">
            <b><xsl:value-of select="$objtypename"/></b>&#160; : &#160;
            <b><xsl:value-of select="/project/@name"/></b>
        </td>
        <td align="left">
            <a href="#" onClick="ExpandAll()" class="PSHYPERLINKHEADER">
            <img src="../source/images/EXPAND.gif" border="0"/>Expand All </a>&#160;
            <a href="#" onClick="CollapseAll()" class="PSHYPERLINKHEADER">
            <img src="../source/images/COLLAPSE.gif" border="0"/>Collapse All</a>&#160;
            <a href="#" onClick="ShowAllAttributes()" class="PSHYPERLINKHEADER">
            <img src="../source/images/SHOW_ALL.gif" border="0"/>Show All Attributes</a>
        </td>
        <xsl:if test="$js_param1=1">
        <td class="PSTEXT" align="right">First</td>
        <td align="right">
            <img src="../source/images/PT_PREVIOUSROW_D_1.gif"/>
        </td>
        </xsl:if>

        <xsl:if test="$js_param1>1">
        <td>
            <a href="javascript:ObjectTypeSelect('{$firstpage}','{$objtypename}','{$js_param3}','1');" class="PSHYPERLINK">First</a></td>         
        <td>
            <a href="javascript:ObjectTypeSelect('{$previouspage}','{$objtypename}','{$js_param3}', '{$previouspagenumber}');" class="PSHYPERLINK">
            <img src="../source/images/PT_PREVIOUSROW_1.gif" border="0"/></a>
        </td>
        </xsl:if>

        <td align="center" class="PSTEXTPAGING">
            <xsl:value-of disable-output-escaping="yes"    select="$firstitem"/> to 
            <xsl:value-of disable-output-escaping="yes"    select="$lastitem"/> of 
            <xsl:value-of disable-output-escaping="yes"    select="$js_param2"/>
        </td>
        <xsl:if test="$js_param1 &lt; $js_param3">
        <td>
            <a href="javascript:ObjectTypeSelect('{$nextpage}','{$objtypename}', '{$js_param3}','{$nextpagenumber}');" class="PSHYPERLINK">
            <img src="../source/images/PT_NEXTROW_1.gif" border="0"/></a>
        </td>
        <td>
            <a href="javascript:ObjectTypeSelect('{$lastpage}','{$objtypename}','{$js_param3}','{$js_param3}');" class="PSHYPERLINK">Last</a>
        </td>
        </xsl:if>
        
        <xsl:if test="$js_param1=$js_param3">
        <td>
            <img src="../source/images/PT_NEXTROW_D_1.gif"/>
        </td>
        <td class="PSTEXT">Last</td>
        </xsl:if>
    </tr>
</table>

<!-- Object name rows -->

</xsl:template>

<!-- EOF -->
</xsl:stylesheet>