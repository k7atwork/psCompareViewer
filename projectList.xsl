<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="html"/>

<xsl:template match="/">
    <table width="50%" >
    <tr class="PTNAVBACKGROUND">
        <td valign="top" width="100%">
            <table class="PTPAGELET" id="tblobjtype" cellspacing="0" cellpadding="0" width="100%" border="1">

                <tr>
                    <td class="PTPAGELETHEADER">Project Name</td>
                    <td class="PTPAGELETHEADER">Description</td>
                </tr>
                <xsl:for-each select="project_list/project">
                <xsl:sort select="@name"/>
                <xsl:variable name="objtypename" select="@name"/>
                <xsl:variable name="description" select="@descr"/>
                <xsl:variable name="titletext" select="concat('View Compare Report for ',@name)"/>
                <tr>
                    <td align="left">
                        <a  href="{$objtypename}/ProjectCompareViewer.html?objtype={$objtypename}"    
                            target="_parent" title="{$titletext}" class="PSHYPERLINK">
                        <xsl:value-of select="@name"/></a>
                    </td>
                    <td class="PTPAGELETBODY">
                        <xsl:value-of select="@descr"/>
                    </td>
                </tr>
                </xsl:for-each>
            </table>
        </td>
    </tr>
    </table>

</xsl:template>

<!-- EOF -->
</xsl:stylesheet>