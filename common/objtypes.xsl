<?xml version='1.0'?>
<!-- 
 * objtypes.xsl
 * This page is used to format the definition types available with project.xml
 * This xsl is being called from objtypes.html
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="html"/>

<xsl:template match="/">
    <table width="100%">
    <tr class="PTNAVBACKGROUND">
        <td valign="top" width="100%">
            <table class="PTPAGELET" id="tblviewertype" cellspacing="0" cellpadding="0" width="100%" border="1">
				<tr valign="center" class="PTNAVBACKGROUND">
                    <td class="PTPAGELETHEADER" valign="center" >Viewer</td>
                </tr>
				<tr>
				<td class="PTPAGELETBODY" width="100%">
					<table cellspacing="5" cellpadding="0" width="100%" border="0">
						<tr valign="center" class="PTNAVBACKGROUND"> 
							<td valign="center" >
								<a  href="../CompareViewer.html" target="_parent" class="PSHYPERLINK">
					          Select Project</a>
							</td>
						</tr>
						<tr valign="center" class="PTNAVBACKGROUND"> 
							<td valign="center" >
							<a href="Search.html" target="viewarea" class="PSHYPERLINK">Search</a>
							</td>
						</tr>
						<tr valign="center" class="PTNAVBACKGROUND"> 
							<td valign="center" >
							<a href="header.html" target="viewarea" class="PSHYPERLINK">Report Details</a>
							</td>
						</tr>
						<tr valign="center" class="PTNAVBACKGROUND"> 
							<td valign="center" >
							<a href="status.html" target="viewarea" class="PSHYPERLINK">Status Summary</a>
							</td>
						</tr>
					</table>
				</td>
				</tr>
			</table>
			<table><tr><td></td></tr></table>
			<table class="PTPAGELET" id="tblobjtype" cellspacing="0" cellpadding="0" width="100%" border="1">
				<tr>
                    <td class="PTPAGELETHEADER">Definition Types</td>
                </tr>
                <tr>
                    <td class="PTPAGELETBODY" width="100%">
                        <table cellspacing="5" cellpadding="0" width="100%" border="0">
							<xsl:for-each select="project/object_type">
							<xsl:sort select="@name"/>
							  <tr valign="center" class="PTNAVBACKGROUND"> 
								<xsl:variable name="objtypename" select="@name"/>
								<xsl:variable name="titletext" select="concat('View Compare Report for ',@name)"/>
								<td align="left"><a  href="viewarea.html?objtype={$objtypename}" 
									 target="viewarea" 
								 title="{$titletext}" class="PSHYPERLINK">
								   <xsl:value-of select="@name"/></a>
								</td>
							  </tr> 
							</xsl:for-each>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    </table>

</xsl:template>

<!-- EOF -->
</xsl:stylesheet>