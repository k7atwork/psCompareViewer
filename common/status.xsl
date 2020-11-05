<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html"/>
<xsl:template match="/">
  <table border="0" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID">
        <tr class="PSLEVEL1GRIDLABEL" align="left"> 
            <td colspan="6"><b>Status Summary - 
                <xsl:value-of select="project/projname"/></b>
            </td>
        </tr>
    </table>
    <table border="1" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID">
        <tr class="PTNAVBACKGROUND"> 
            <td align="left" class="PSLEVEL1GRIDCOLUMNHDR">Definition Type</td>
            <td align="right" class="PSLEVEL1GRIDCOLUMNHDR">Customer Added</td>
            <td align="right" class="PSLEVEL1GRIDCOLUMNHDR">Customer Modified</td>
            <td align="right" class="PSLEVEL1GRIDCOLUMNHDR">PeopleSoft Deleted</td>
            <td align="right" class="PSLEVEL1GRIDCOLUMNHDR">PeopleSoft Added</td>
            <td align="right" class="PSLEVEL1GRIDCOLUMNHDR">PeopleSoft Modified</td>
        </tr>
        <xsl:for-each select="project/object_type">
        <xsl:sort select="@name"/>
        
        <xsl:variable name="ACC" select="summary/Absent_CustChanged"/>
        <xsl:variable name="ACU" select="summary/Absent_CustUnchanged"/>
        <xsl:variable name="Customer_Added" select="$ACC+$ACU"/>

        <xsl:variable name="CCC" select="summary/Changed_CustChanged"/>
        <xsl:variable name="CCUC" select="summary/Changed_CustUnchanged"/>
        <xsl:variable name="UCCC" select="summary/Unchanged_CustChanged"/>
        <xsl:variable name="UCCU" select="summary/Unchanged_CustUnchanged"/>
        <xsl:variable name="Customer_Modified" select="$CCC+$CCUC+$UCCC+$UCCU"/>

        <xsl:variable name="AC" select="summary/Absent_Changed"/>
        <xsl:variable name="AU" select="summary/Absent_Unchanged"/>
        <xsl:variable name="PeopleSoft_Deleted" select="$AC+$AU"/>

        <xsl:variable name="CA" select="summary/Changed_Absent"/>
        <xsl:variable name="UA" select="summary/Unchanged_Absent"/>
        <xsl:variable name="CCA" select="summary/CustChanged_Absent"/>
        <xsl:variable name="CUA" select="summary/CustUnchanged_Absent"/>
        <xsl:variable name="PeopleSoft_Added" select="$CA+$UA+$CCA+$CUA"/>
               
        <xsl:variable name="CC" select="summary/Changed_Changed"/>
        <xsl:variable name="CU" select="summary/Changed_Unchanged"/>
        <xsl:variable name="UC" select="summary/Unchanged_Changed"/>
        <xsl:variable name="UU" select="summary/Unchanged_Unchanged"/>
        <xsl:variable name="PeopleSoft_Modified" select="$CC+$CU+$UC+$UU"/>
        
        <xsl:variable name="rowclass">
        <xsl:choose>
        <xsl:when test="position() mod 2=0">
          PSLEVEL1GRIDEVENROW
        </xsl:when>
        <xsl:otherwise>
          PSLEVEL1GRIDODDROW
        </xsl:otherwise>
        </xsl:choose>
        </xsl:variable>
      <xsl:variable name="item_name" select="@name"/>
        <tr class="PSLEVEL1GRIDEVENROW">
            <xsl:variable name="ATD" select="concat('A_',$item_name)"/>
            <xsl:variable name="BTD" select="concat('B_',$item_name)"/>
            <xsl:variable name="CTD" select="concat('C_',$item_name)"/>
            <xsl:variable name="DTD" select="concat('D_',$item_name)"/>
            <xsl:variable name="ETD" select="concat('E_',$item_name)"/>
            <td align="left" class="{$rowclass}">
               	<a href="definitionstatus.html?objtype={$item_name}"> <xsl:value-of select="@name"/> </a>
            </td>
            <td align="right" class="{$rowclass}"  id="{$ATD}">
                <xsl:if test="$Customer_Added!=0">
                    <a href="view_summary.html?objtype={$item_name}?Template=CATemplate" 
                    target="viewarea" class="PSHYPERLINK">
                    <xsl:value-of select="$Customer_Added"/></a>
                </xsl:if>
                <xsl:if test="$Customer_Added=0">
                    <xsl:value-of select="$Customer_Added"/>
                </xsl:if>
            </td>
            <td align="right" class="{$rowclass}" id="{$BTD}">
                <xsl:if test="$Customer_Modified!=0">
                    <a href="view_summary.html?objtype={$item_name}?Template=CMTemplate" 
                    target="viewarea" class="PSHYPERLINK">
                    <xsl:value-of select="$Customer_Modified"/></a>
                </xsl:if>
                <xsl:if test="$Customer_Modified = 0">
                    <xsl:value-of select="$Customer_Modified"/>
                </xsl:if>
            </td>
            <td align="right" class="{$rowclass}" id="{$CTD}">
                <xsl:if test="$PeopleSoft_Deleted!=0">
                    <a href="view_summary.html?objtype={$item_name}?Template=PDTemplate" 
                    target="viewarea" class="PSHYPERLINK">
                    <xsl:value-of select="$PeopleSoft_Deleted"/></a>
                </xsl:if>
                <xsl:if test="$PeopleSoft_Deleted = 0">
                    <xsl:value-of select="$PeopleSoft_Deleted"/>
                </xsl:if>
            </td>
            <td align="right" class="{$rowclass}" id="{$DTD}">
                <xsl:if test="$PeopleSoft_Added!=0">
                    <a href="view_summary.html?objtype={$item_name}?Template=PATemplate" 
                    target="viewarea" class="PSHYPERLINK">
                    <xsl:value-of select="$PeopleSoft_Added"/></a>
                </xsl:if>
                <xsl:if test="$PeopleSoft_Added=0">
                    <xsl:value-of select="$PeopleSoft_Added"/>
                </xsl:if>
            </td>
            <td align="right" class="{$rowclass}" id="{$ETD}">
                <xsl:if test="$PeopleSoft_Modified!=0">
                    <a href="view_summary.html?objtype={$item_name}?Template=PMTemplate" 
                    target="viewarea" class="PSHYPERLINK">
                    <xsl:value-of select="$PeopleSoft_Modified"/></a>
                </xsl:if>
                <xsl:if test="$PeopleSoft_Modified=0">
                    <xsl:value-of select="$PeopleSoft_Modified"/>
                </xsl:if>
            </td>
        </tr>
    </xsl:for-each>
        <tr class="PSLEVEL1GRIDLABEL">
            <td align="left">Total</td>
            <td align="right" id="CA"></td>
            <td align="right" id="CM"></td>
            <td align="right" id="CD"></td>
            <td align="right" id="PA"></td>
            <td align="right" id="PM"></td>
        </tr>
    </table>
</xsl:template>

<!-- EOF -->
</xsl:stylesheet>
