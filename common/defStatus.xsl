<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/>
<xsl:param name="js_param"/>
<xsl:param name="js_param2"/>

<xsl:template match="/">
  <table border="0" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID">
        <tr class="PTNAVBACKGROUND" align="left"> 
		<td colspan="6"><b>
                <xsl:value-of select="$js_param"/> 
				Status Summary - 
				<xsl:value-of select="project/projname"/> </b>
            </td>
        </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID">
	    
        <tr class="PTNAVBACKGROUND" > 
		<td align="center" class="PSSOURCEGRIDLABEL"><b>
				Source</b>
            </td>
		<td colspan="5" align="center" class="PSTARGETGRIDLABEL"><b>
				Target</b>
            </td>
        </tr>
        <tr class="PSLEVEL1GRIDEVENROW"> 
            <td align="left" class="PSSOURCEGRIDCOLUMNHDR">   </td>
            <td align="left" class="PSLEVEL1GRIDCOLUMNHDR">Absent</td>
            <td align="left" class="PSLEVEL1GRIDCOLUMNHDR">Unchanged</td>
            <td align="left" class="PSLEVEL1GRIDCOLUMNHDR">Changed</td>
            <td align="left" class="PSLEVEL1GRIDCOLUMNHDR">Custom Unchanged</td>
            <td align="left" class="PSLEVEL1GRIDCOLUMNHDR">Custom Changed</td>
        </tr>
	<xsl:apply-templates select="project/object_type" mode="doMatch" />
    </table>
</xsl:template>

<xsl:template match="project/object_type" mode="doMatch">
	<xsl:variable name="type" select="./@name"/>
	<xsl:if test="$type=$js_param">
		<xsl:call-template name="matched" />
	</xsl:if>
</xsl:template>

<xsl:template name="matched" >
        
        <xsl:variable name="AU" select="summary/Absent_Unchanged"/>
        <xsl:variable name="AC" select="summary/Absent_Changed"/>
        <xsl:variable name="ACU" select="summary/Absent_CustUnchanged"/>
        <xsl:variable name="ACC" select="summary/Absent_CustChanged"/>

        <xsl:variable name="UA" select="summary/Unchanged_Absent"/>
        <xsl:variable name="UU" select="summary/Unchanged_Unchanged"/>
        <xsl:variable name="UC" select="summary/Unchanged_Changed"/>
        <xsl:variable name="UCCU" select="summary/Unchanged_CustUnchanged"/>
        <xsl:variable name="UCCC" select="summary/Unchanged_CustChanged"/>

        <xsl:variable name="CA" select="summary/Changed_Absent"/>
        <xsl:variable name="CU" select="summary/Changed_Unchanged"/>
        <xsl:variable name="CC" select="summary/Changed_Changed"/>
        <xsl:variable name="CCUC" select="summary/Changed_CustUnchanged"/>
        <xsl:variable name="CCC" select="summary/Changed_CustChanged"/>

        <xsl:variable name="CUA" select="summary/CustUnchanged_Absent"/>
        <xsl:variable name="CUUC" select="summary/CustUnchanged_Unchanged"/>
        <xsl:variable name="CUC" select="summary/CustUnchanged_Changed"/>
        <xsl:variable name="CUCU" select="summary/CustUnchanged_CustUnchanged"/>
        <xsl:variable name="CUCC" select="summary/CustUnchanged_CustChanged"/>
               
        <xsl:variable name="CCA" select="summary/CustChanged_Absent"/>
        <xsl:variable name="CCU" select="summary/CustChanged_Unchanged"/>
        <xsl:variable name="CCCh" select="summary/CustChanged_Changed"/>
        <xsl:variable name="CCCU" select="summary/CustChanged_CustUnchanged"/>
        <xsl:variable name="CCCC" select="summary/CustChanged_CustChanged"/>
        
	<xsl:variable name="rowclass" select="'PSLEVEL1GRIDEVENROW'"/>
	<xsl:variable name="rowclass2" select="'PSLEVEL1GRIDODDROW'"/>
      <xsl:variable name="item_name" select="@name"/>
        <tr class="PSLEVEL1GRIDODDROW">
            <td align="left" class="PSSOURCEGRIDCOLUMNHDR">Absent</td>
	    <td align="right" class="{$rowclass2}">X</td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$AU=0">
		    <xsl:value-of select="$AU" />
	    </xsl:if>
	    <xsl:if test="$AU!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=AU"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$AU" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$AC=0">
		    <xsl:value-of select="$AC" />
	    </xsl:if>
	    <xsl:if test="$AC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=AC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$AC" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$ACU=0">
		    <xsl:value-of select="$ACU" />
	    </xsl:if>
	    <xsl:if test="$ACU!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=ACU"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$ACU" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$ACC=0">
		    <xsl:value-of select="$ACC" />
	    </xsl:if>
	    <xsl:if test="$ACC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=ACC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$ACC" />
		    </a>
	    </xsl:if>
	    </td>
        </tr>
        <tr class="PSLEVEL1GRIDEVENROW">
            <td align="left" class="PSSOURCEGRIDCOLUMNHDR">Unchanged</td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$UA=0">
		    <xsl:value-of select="$UA" />
	    </xsl:if>
	    <xsl:if test="$UA!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=UA"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$UA" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$UU=0">
		    <xsl:value-of select="$UU" />
	    </xsl:if>
	    <xsl:if test="$UU!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=UU"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$UU" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$UC=0">
		    <xsl:value-of select="$UC" />
	    </xsl:if>
	    <xsl:if test="$UC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=UC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$UC" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$UCCU=0">
		    <xsl:value-of select="$UCCU" />
	    </xsl:if>
	    <xsl:if test="$UCCU!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=UCCU"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$UCCU" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$UCCC=0">
		    <xsl:value-of select="$UCCC" />
	    </xsl:if>
	    <xsl:if test="$UCCC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=UCCC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$UCCC" />
		    </a>
	    </xsl:if>
	    </td>
        </tr>
        <tr class="PSLEVEL1GRIDODDROW">
            <td align="left" class="PSSOURCEGRIDCOLUMNHDR">Changed</td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CA=0">
		    <xsl:value-of select="$CA" />
	    </xsl:if>
	    <xsl:if test="$CA!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CA"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CA" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CU=0">
		    <xsl:value-of select="$CU" />
	    </xsl:if>
	    <xsl:if test="$CU!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CU"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CU" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CC=0">
		    <xsl:value-of select="$CC" />
	    </xsl:if>
	    <xsl:if test="$CC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CC" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CCUC=0">
		    <xsl:value-of select="$CCUC" />
	    </xsl:if>
	    <xsl:if test="$CCUC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CCUC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CCUC" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CCC=0">
		    <xsl:value-of select="$CCC" />
	    </xsl:if>
	    <xsl:if test="$CCC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CCC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CCC" />
		    </a>
	    </xsl:if>
	    </td>
        </tr>
        <tr class="PSLEVEL1GRIDEVENROW">
            <td align="left" class="PSSOURCEGRIDCOLUMNHDR">Custom Unchanged</td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$CUA=0">
		    <xsl:value-of select="$CUA" />
	    </xsl:if>
	    <xsl:if test="$CUA!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CUA"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CUA" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$CUUC=0">
		    <xsl:value-of select="$CUUC" />
	    </xsl:if>
	    <xsl:if test="$CUUC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CUUC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CUUC" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$CUC=0">
		    <xsl:value-of select="$CUC" />
	    </xsl:if>
	    <xsl:if test="$CUC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CUC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CUC" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$CUCU=0">
		    <xsl:value-of select="$CUCU" />
	    </xsl:if>
	    <xsl:if test="$CUCU!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CUCU"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CUCU" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass}">
	    <xsl:if test="$CUCC=0">
		    <xsl:value-of select="$CUCC" />
	    </xsl:if>
	    <xsl:if test="$CUCC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CUCC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CUCC" />
		    </a>
	    </xsl:if>
	    </td>
        </tr>
        <tr class="PSLEVEL1GRIDODDROW">
            <td align="left" class="PSSOURCEGRIDCOLUMNHDR">Custom Changed</td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CCA=0">
		    <xsl:value-of select="$CCA" />
	    </xsl:if>
	    <xsl:if test="$CCA!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CCA"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CCA" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CCU=0">
		    <xsl:value-of select="$CCU" />
	    </xsl:if>
	    <xsl:if test="$CCU!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CCU"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CCU" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CCCh=0">
		    <xsl:value-of select="$CCCh" />
	    </xsl:if>
	    <xsl:if test="$CCCh!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CCCh"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CCCh" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CCCU=0">
		    <xsl:value-of select="$CCCU" />
	    </xsl:if>
	    <xsl:if test="$CCCU!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CCCU"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CCCU" />
		    </a>
	    </xsl:if>
	    </td>
	    <td align="right" class="{$rowclass2}">
	    <xsl:if test="$CCCC=0">
		    <xsl:value-of select="$CCCC" />
	    </xsl:if>
	    <xsl:if test="$CCCC!=0">
		    <a href="view_summary.html?objtype={$js_param}?Template=CCCC"
			    target="viewarea" class="PSHYPERLINK">
			    <xsl:value-of select="$CCCC" />
		    </a>
	    </xsl:if>
	    </td>
        </tr>
</xsl:template>

<!-- EOF -->
</xsl:stylesheet>
