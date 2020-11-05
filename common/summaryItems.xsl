<?xml version='1.0'?>
<!-- 
 * summaryItems.xsl
 * This page is used to format the the search result
 * This xsl is being called from result.html
 * It expects a parameter from the JS method for total Item count
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="html"/>
<xsl:param name="js_param"/>

<xsl:template match="/">
  <xsl:apply-templates select="/project" mode="keylist" />
</xsl:template>

<!-- Object names per type, mode = "keylist" -->

<xsl:template match="/project" mode="keylist">
<!-- Object Type Name table -->
<table border="0" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID">
    <tr class="PSLEVEL1GRIDLABEL" valign="bottom"> 
        <td align="left" border="2">
            <b><xsl:value-of select="/project/@objectType"/></b>&#160; : &#160;
            <b><xsl:value-of select="/project/@name"/></b>
        </td>
        <td align="right" border="0">
                <xsl:if test="($js_param='CATemplate')">
                    <b>Customer Added</b>
                </xsl:if>
                <xsl:if test="($js_param='CMTemplate')">
                    <b>Customer Modified</b>
                </xsl:if>
                <xsl:if test="($js_param='PDTemplate')">
                    <b>PeopleSoft Deleted</b>
                </xsl:if>
                <xsl:if test="($js_param='PATemplate')">
                    <b>PeopleSoft Added</b>
                </xsl:if>
                <xsl:if test="($js_param='PMTemplate')">
                    <b>PeopleSoft Modified</b>
                </xsl:if>
        </td>
    </tr>
</table>
<table border="1" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID">
    <tr>
        <td colspan="2">
        <!-- Object name rows -->
        <!-- column headers -->
            <table border="0" cellspacing="0" cellpadding="2" style="border-style:none;" width="100%" class="PSTEXT">
                <tr valign="center" align="left"> 
                    <xsl:for-each select="primary_key">
                    <td class="PSLEVEL1GRIDCOLUMNHDR"><xsl:value-of select="."/></td>
                    </xsl:for-each>
        
                    <td class="PSLEVEL1GRIDCOLUMNHDR">Source</td>
                    <td class="PSLEVEL1GRIDCOLUMNHDR">Target</td>
                    <td class="PSLEVEL1GRIDCOLUMNHDR">Action</td>
                    <td class="PSLEVEL1GRIDCOLUMNHDR">Upgrade</td>
                </tr>

                <!-- Item List -->
                <xsl:if test="($js_param='CATemplate')">
                    <xsl:apply-templates select="item[source_status='Absent' and (target_status='*Changed' or target_status='*Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CMTemplate')">
                    <xsl:apply-templates select="item[(source_status ='Changed' or source_status ='Unchanged') and (target_status='*Changed' or target_status='*Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='PDTemplate')">
                    <xsl:apply-templates select="item[source_status='Absent' and (target_status ='Changed' or target_status ='Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='PATemplate')">
                    <xsl:apply-templates select="item[(source_status ='Changed' or source_status ='Unchanged' or source_status='*Changed' or source_status='*Unchanged') and target_status ='Absent']" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='PMTemplate')">
                    <xsl:apply-templates select="item[(source_status ='Changed' or source_status ='Unchanged') and (target_status ='Changed' or target_status ='Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='AU')">
                    <xsl:apply-templates select="item[(source_status ='Absent' and target_status ='Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='AC')">
                    <xsl:apply-templates select="item[(source_status ='Absent' and target_status ='Changed')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='ACU')">
                    <xsl:apply-templates select="item[(source_status ='Absent' and target_status ='*Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='ACC')">
                    <xsl:apply-templates select="item[(source_status ='Absent' and target_status ='*Changed')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='UA')">
                    <xsl:apply-templates select="item[(source_status ='Unchanged' and target_status ='Absent')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='UU')">
                    <xsl:apply-templates select="item[(source_status ='Unchanged' and target_status ='Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='UC')">
                    <xsl:apply-templates select="item[(source_status ='Unchanged' and target_status ='Changed')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='UCCU')">
                    <xsl:apply-templates select="item[(source_status ='Unchanged' and target_status ='*Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='UCCC')">
                    <xsl:apply-templates select="item[(source_status ='Unchanged' and target_status ='*Changed')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CA')">
                    <xsl:apply-templates select="item[(source_status ='Changed' and target_status ='Absent')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CU')">
                    <xsl:apply-templates select="item[(source_status ='Changed' and target_status ='Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CC')">
                    <xsl:apply-templates select="item[(source_status ='Changed' and target_status ='Changed')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CCUC')">
                    <xsl:apply-templates select="item[(source_status ='Changed' and target_status ='*Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CCC')">
                    <xsl:apply-templates select="item[(source_status ='Changed' and target_status ='*Changed')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CUA')">
                    <xsl:apply-templates select="item[(source_status ='*Unchanged' and target_status ='Absent')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CUUC')">
                    <xsl:apply-templates select="item[(source_status ='*Unchanged' and target_status ='Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CUC')">
                    <xsl:apply-templates select="item[(source_status ='*Unchanged' and target_status ='Changed')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CUCU')">
                    <xsl:apply-templates select="item[(source_status ='*Unchanged' and target_status ='*Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CUCC')">
                    <xsl:apply-templates select="item[(source_status ='*Unchanged' and target_status ='*Changed')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CCA')">
                    <xsl:apply-templates select="item[(source_status ='*Changed' and target_status ='Absent')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CCU')">
                    <xsl:apply-templates select="item[(source_status ='*Changed' and target_status ='Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CCCh')">
                    <xsl:apply-templates select="item[(source_status ='*Changed' and target_status ='Changed')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CCCU')">
                    <xsl:apply-templates select="item[(source_status ='*Changed' and target_status ='*Unchanged')]" mode="CATemplate"/>
                </xsl:if>
                <xsl:if test="($js_param='CCCC')">
                    <xsl:apply-templates select="item[(source_status ='*Changed' and target_status ='*Changed')]" mode="CATemplate"/>
                </xsl:if>
            </table>
        </td>
    </tr>
   <tr class="PSLEVEL1GRIDLABEL">
           <td align="right">Run Date: 
        <xsl:value-of select="/project/rundate"/>
        </td>
   </tr>
</table>

<p></p>
</xsl:template>


<!-- list by object name Customer Added primary keys -->
<xsl:template match="item" mode="CATemplate">
    <xsl:variable name="objtypename" select="../@objectType"/>
    <xsl:variable name="itemid" select="@id"/>
    <xsl:variable name="template" select="'CATemplate'"/>
    <xsl:variable name="titletext" select="concat('Expand ',$itemid)"/>

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

    <tr>
        <xsl:for-each select="objname">
           <td class="{$rowclass}">
           <a id="{$itemid}" href="javascript:summaryItemSelect('{$objtypename}','{$itemid}','{$js_param}');" title="{$titletext}" class="PSHYPERLINK">
           <xsl:value-of select="."/></a>
           </td>
        </xsl:for-each>
        <td class="{$rowclass}"><xsl:value-of select="source_status"/></td>
        <td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="action" /></td>
        <td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
    </tr>
</xsl:template>

<!-- list by object name customer Modified primary keys -->
<xsl:template match="item" mode="CMTemplate">
    <xsl:variable name="objtypename" select="../@objectType"/>
    <xsl:variable name="itemid" select="@id"/>
    <xsl:variable name="template" select="'CMTemplate'"/>
    <xsl:variable name="titletext" select="concat('Expand ',$itemid)"/>

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

    <tr>
        <xsl:for-each select="objname">
           <td class="{$rowclass}">
           <a id="{$itemid}" href="javascript:summaryItemSelect('{$objtypename}','{$itemid}','{$template}');" title="{$titletext}" class="PSHYPERLINK">
           <xsl:value-of select="."/></a>
           </td>
        </xsl:for-each>
        <td class="{$rowclass}"><xsl:value-of select="source_status"/></td>
        <td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="action" /></td>
        <td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
    </tr>
</xsl:template>

<!-- list by object name PeopleSoft Deleted primary keys -->
<xsl:template match="item" mode="PDTemplate">
    <xsl:variable name="objtypename" select="../@objectType"/>
    <xsl:variable name="itemid" select="@id"/>
    <xsl:variable name="template" select="'PDTemplate'"/>
    <xsl:variable name="titletext" select="concat('Expand ',$itemid)"/>

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

    <tr>
        <xsl:for-each select="objname">
           <td class="{$rowclass}">
           <a id="{$itemid}" href="javascript:summaryItemSelect('{$objtypename}','{$itemid}','{$template}');" title="{$titletext}" class="PSHYPERLINK">
           <xsl:value-of select="."/></a>
           </td>
        </xsl:for-each>
        <td class="{$rowclass}"><xsl:value-of select="source_status"/></td>
        <td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="action" /></td>
        <td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
    </tr>
</xsl:template>

<!-- list by object name PeopleSoft Added primary keys -->
<xsl:template match="item" mode="PATemplate">
    <xsl:variable name="objtypename" select="../@objectType"/>
    <xsl:variable name="itemid" select="@id"/>
    <xsl:variable name="template" select="'PATemplate'"/>
    <xsl:variable name="titletext" select="concat('Expand ',$itemid)"/>

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

    <tr>
        <xsl:for-each select="objname">
           <td class="{$rowclass}">
           <a id="{$itemid}" href="javascript:summaryItemSelect('{$objtypename}','{$itemid}','{$template}');" title="{$titletext}" class="PSHYPERLINK">
           <xsl:value-of select="."/></a>
           </td>
        </xsl:for-each>
        <td class="{$rowclass}"><xsl:value-of select="source_status"/></td>
        <td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="action" /></td>
        <td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
    </tr>
</xsl:template>

<!-- list by object name PeopleSoft Modified primary keys -->
<xsl:template match="item" mode="PMTemplate">
    <xsl:variable name="objtypename" select="../@objectType"/>
    <xsl:variable name="itemid" select="@id"/>
    <xsl:variable name="template" select="'PMTemplate'"/>
    <xsl:variable name="titletext" select="concat('Expand ',$itemid)"/>

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

    <tr>
        <xsl:for-each select="objname">
           <td class="{$rowclass}">
           <a id="{$itemid}" href="javascript:summaryItemSelect('{$objtypename}','{$itemid}','{$template}');" title="{$titletext}" class="PSHYPERLINK">
           <xsl:value-of select="."/></a>
           </td>
        </xsl:for-each>
        <td class="{$rowclass}"><xsl:value-of select="source_status"/></td>
        <td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="action" /></td>
        <td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
    </tr>
</xsl:template>

<!-- EOF -->
</xsl:stylesheet>
