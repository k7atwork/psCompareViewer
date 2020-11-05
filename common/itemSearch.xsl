<?xml version='1.0'?>
<!-- 
 * itemSearch.xsl
 * This page is used to format the the search result
 * This xsl is being called from result.html
 * It expects a parameter from the JS method for Item ID
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="html"/>
<xsl:param name="js_param"/>
<xsl:param name="js_param2"/>

<xsl:template match="/">

  <xsl:apply-templates select="/project/object_type" mode="keylist" />

</xsl:template>


<!-- Object names per type, mode = "keylist" -->

<xsl:template match="/project/object_type" mode="keylist">
<!-- Object Type Name table -->
<table border="0" cellspacing="0" cellpadding="1" cols="1" width="100%" class="PSLEVEL1GRID">
    <tr class="PSLEVEL1GRIDLABEL">
        <td align="left">Search Result</td>
        <td align="center">
            Run Date: <xsl:value-of select="../rundate"/>
        </td>
        <td align="right">
            <a href="#" onClick="ExpandAll()" class="PSHYPERLINKHEADER">
            <img src="../source/images/EXPAND.gif" border="0"/>&#160; Expand All </a>&#160;
            <a href="#" onClick="CollapseAll()" class="PSHYPERLINKHEADER">
            <img src="../source/images/COLLAPSE.gif" border="0"/>Collapse All</a>&#160;
            <a href="#" onClick="ShowAllAttributes()" class="PSHYPERLINKHEADER">
            <img src="../source/images/SHOW_ALL.gif" border="0"/>Show All Attributes</a>
        </td>
    </tr>
</table>
<table border="1" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID">
    <tr>
        <td>
            <!-- Object name rows -->
            <!-- column headers -->
            <table border="0" cellspacing="0" cellpadding="0" style="border-style:none;" width="100%" class="PSTEXT"  id="outertbl">
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
                <!-- <xsl:apply-templates select="//item[starts-with(@id,$js_param)]" mode="keylist" /> -->
                
               	<xsl:variable name="checkCode" select="/project/object_type/@code"/>
		<xsl:if test="($js_param2='composite')">
                	<xsl:if test="($checkCode='true')">
                    		<xsl:apply-templates select="//item[starts-with(@id,$js_param)]" mode="CmpKeylist" />
                	</xsl:if>
                	<xsl:if test="($checkCode='false')">
                    		<xsl:apply-templates select="//item[starts-with(@id,$js_param)]" mode="CmpKeylistA" />
                	</xsl:if>
                </xsl:if>
		<xsl:if test="(not($js_param2='composite'))">
                	<xsl:if test="($checkCode='true')">
                    		<xsl:apply-templates select="//item[starts-with(@id,$js_param)]" mode="keylist" />
                	</xsl:if>
                	<xsl:if test="($checkCode='false')">
                    		<xsl:apply-templates select="//item[starts-with(@id,$js_param)]" mode="keylistA" />
                	</xsl:if>
                </xsl:if>
            </table>
        </td>
    </tr>
   <tr class="PSLEVEL1GRIDLABEL">
        <td align="right">Run Date: 
        <xsl:value-of select="../rundate"/>
        </td>
   </tr>
</table>

<p></p>
</xsl:template>

<!-- list by object name primary keys -->
<xsl:template match="item" mode="keylist">
    <xsl:variable name="objtypename" select="../@name"/>
    <xsl:variable name="itemid" select="@id"/>
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
           <a id="{$itemid}" href="javascript:ItemSelect('{$objtypename}','{$itemid}');" title="{$titletext}" class="PSHYPERLINK">
           <xsl:value-of select="."/></a>
        </td>
        </xsl:for-each>
        <td class="{$rowclass}"><xsl:value-of select="source_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="action" /></td>
        <td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
  </tr>

  <!-- attribute table  -->
  <xsl:variable name="tblid" select="concat('tbl',$itemid)"/>
  <tr>
    <td colspan="11">
        <table id="{$tblid}" cellspacing="0" cellpadding="2" border="0" frame="border" style="display:none" width="100%" class="PSTEXT">
            <tr valign="center" align="left">
                <xsl:for-each select="../secondary_key">
                <td class="PSLEVEL1GRIDCOLUMNHDR"><xsl:value-of select="."/></td>
                </xsl:for-each>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Attribute</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Source</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR"></td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Target</td>
            </tr>

                <xsl:for-each select="secondary_key">
                <xsl:variable name="secondary_keyposition" select="position()"/>

                <xsl:variable name="rowclass2">
                    <xsl:choose>
                        <xsl:when test="position() mod 2=0">
                            PSLEVEL1GRIDEVENROWx
                        </xsl:when>
                        <xsl:otherwise>
                            PSLEVEL1GRIDODDROWx
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

            <tr>
                <xsl:for-each select="value">
                    <td class="{$rowclass2}"><xsl:value-of select="."/></td>
                </xsl:for-each>
                <xsl:variable name="value" select="value"/>
            </tr>

        <xsl:for-each select="attribute">
                <xsl:variable name="attribname" select="@name"/>
                <xsl:variable name="cSource" select="@diff"/>
                <xsl:variable name="atitletext" select="concat('Hide all [', $attribname, '] attributes')"/>
                <xsl:variable name="attribid" select="concat($secondary_keyposition,$itemid,$value,position(),$attribname)"/>
                <xsl:variable name="atitletext1" select="concat('Hide this attribute',' ')"/>

            <tr   id="{$attribid}" name="{$attribname}">
                <xsl:for-each select="../value">
                    <td class="{$rowclass2}"></td>
                </xsl:for-each>
                <td  class="{$rowclass2}"><xsl:value-of select="@name"/></td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="source"/></td>
                <td>
                <xsl:if test="($cSource='same')"></xsl:if>
                <xsl:if test="($cSource='targetonly')">
                <img src="../source/images/RIGHT_ARROW.gif" width="16" height="16" border="0"/> 
                </xsl:if>
                <xsl:if test="($cSource='sourceonly')">
                <img src="../source/images/LEFT_ARROW.gif" width="16" height="16" border="0"/> 
                </xsl:if>
                </td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="target"/></td>
            </tr>
        </xsl:for-each>
    </xsl:for-each>
  </table>
  </td></tr>

<!-- </xsl:if> -->
</xsl:template>
<xsl:template match="item" mode="keylistA">
    <xsl:variable name="objtypename" select="../@name"/>
    <xsl:variable name="itemid" select="@id"/>
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
           <a id="{$itemid}" href="javascript:ItemSelect('{$objtypename}','{$itemid}');" title="{$titletext}" class="PSHYPERLINK">
           <xsl:value-of select="."/></a>
        </td>
        </xsl:for-each>
        <td class="{$rowclass}"><xsl:value-of select="source_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="action" /></td>
        <td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
  </tr>

  <!-- attribute table  -->
  <xsl:variable name="tblid" select="concat('tbl',$itemid)"/>
  <tr>
    <td colspan="11">
        <table id="{$tblid}" cellspacing="0" cellpadding="2" border="0" frame="border" style="display:none" width="100%" class="PSTEXT">
            <tr valign="center" align="left">
                <xsl:for-each select="../secondary_key">
                <td class="PSLEVEL1GRIDCOLUMNHDR"><xsl:value-of select="."/></td>
                </xsl:for-each>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Attribute</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Source</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Target</td>
            </tr>

                <xsl:for-each select="secondary_key">
                <xsl:variable name="secondary_keyposition" select="position()"/>

                <xsl:variable name="rowclass2">
                    <xsl:choose>
                        <xsl:when test="position() mod 2=0">
                            PSLEVEL1GRIDEVENROWx
                        </xsl:when>
                        <xsl:otherwise>
                            PSLEVEL1GRIDODDROWx
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

            <tr>
                <xsl:for-each select="value">
                    <td class="{$rowclass2}"><xsl:value-of select="."/></td>
                </xsl:for-each>
            </tr>

        <xsl:for-each select="attribute">
                <xsl:variable name="attribname" select="@name"/>
                <xsl:variable name="value" select="value"/>
                <xsl:variable name="atitletext" select="concat('Hide all [', $attribname, '] attributes')"/>
                <xsl:variable name="attribid" select="concat($secondary_keyposition,$itemid,$value,position(),$attribname)"/>
                <xsl:variable name="atitletext1" select="concat('Hide this attribute',' ')"/>

            <tr   id="{$attribid}" name="{$attribname}">
                <xsl:for-each select="../value">
                    <td class="{$rowclass2}"></td>
                </xsl:for-each>
                <td  class="{$rowclass2}"><xsl:value-of select="@name"/></td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="source"/></td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="target"/></td>
                <td  class="{$rowclass2}" >
                    <a href="javascript:HideAttribute('{$attribid}');" title="{$atitletext1}">
                    <img src="../source/images/HIDE.gif" width="9" height="9" border="0"/></a>
                </td>
                <td  class="{$rowclass2}" >
                    <a href="javascript:HideAttributes('{$attribname}');" title="{$atitletext}">
                    <img src="../source/images/HIDEALL.gif" width="16" height="16" border="0"/> </a>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:for-each>
  </table>
  </td></tr>
</xsl:template>

<xsl:template match="item" mode="CmpKeylistA">
    <xsl:variable name="objtypename" select="../@name"/>
    <xsl:variable name="itemid" select="@id"/>
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
           <a id="{$itemid}" href="javascript:ItemSelect('{$objtypename}','{$itemid}');" title="{$titletext}" class="PSHYPERLINK">
           <xsl:value-of select="."/></a>
        </td>
        </xsl:for-each>
        <td class="{$rowclass}"><xsl:value-of select="source_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="action" /></td>
        <td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
  </tr>

  <!-- attribute table  -->
  <xsl:variable name="tblid" select="concat('tbl',$itemid)"/>
  <tr>
    <td colspan="11">
        <table id="{$tblid}" cellspacing="0" cellpadding="2" border="0" frame="border" style="display:none" width="100%" class="PSTEXT">
            <tr valign="center" align="left">
                <xsl:for-each select="../secondary_key">
                <td class="PSLEVEL1GRIDCOLUMNHDR"><xsl:value-of select="."/></td>
                </xsl:for-each>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Attribute</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Old Release</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">New Release</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Customization</td>
            </tr>

                <xsl:for-each select="secondary_key">
                <xsl:variable name="secondary_keyposition" select="position()"/>

                <xsl:variable name="rowclass2">
                    <xsl:choose>
                        <xsl:when test="position() mod 2=0">
                            PSLEVEL1GRIDEVENROWx
                        </xsl:when>
                        <xsl:otherwise>
                            PSLEVEL1GRIDODDROWx
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

            <tr>
                <xsl:for-each select="value">
                    <td class="{$rowclass2}"><xsl:value-of select="."/></td>
                </xsl:for-each>
            </tr>

        <xsl:for-each select="attribute">
                <xsl:variable name="attribname" select="@name"/>
                <xsl:variable name="value" select="value"/>
                <xsl:variable name="atitletext" select="concat('Hide all [', $attribname, '] attributes')"/>
                <xsl:variable name="attribid" select="concat($secondary_keyposition,$itemid,$value,position(),$attribname)"/>
                <xsl:variable name="atitletext1" select="concat('Hide this attribute',' ')"/>

            <tr   id="{$attribid}" name="{$attribname}">
                <xsl:for-each select="../value">
                    <td class="{$rowclass2}"></td>
                </xsl:for-each>
                <td  class="{$rowclass2}"><xsl:value-of select="@name"/></td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="OldRelease"/></td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="NewRelease"/></td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="Customization"/></td>
                <td  class="{$rowclass2}" >
                    <a href="javascript:HideAttribute('{$attribid}');" title="{$atitletext1}">
                    <img src="../source/images/HIDE.gif" width="9" height="9" border="0"/></a>
                </td>
                <td  class="{$rowclass2}" >
                    <a href="javascript:HideAttributes('{$attribname}');" title="{$atitletext}">
                    <img src="../source/images/HIDEALL.gif" width="16" height="16" border="0"/> </a>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:for-each>
  </table>
  </td></tr>
</xsl:template>


<!-- list by object name primary keys -->
<xsl:template match="item" mode="CmpKeylist">
    <xsl:variable name="objtypename" select="../@name"/>
    <xsl:variable name="itemid" select="@id"/>
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
           <a id="{$itemid}" href="javascript:ItemSelect('{$objtypename}','{$itemid}');" title="{$titletext}" class="PSHYPERLINK">
           <xsl:value-of select="."/></a>
        </td>
        </xsl:for-each>
        <td class="{$rowclass}"><xsl:value-of select="source_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
        <td class="{$rowclass}"><xsl:value-of select="action" /></td>
        <td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
  </tr>

  <!-- attribute table  -->
  <xsl:variable name="tblid" select="concat('tbl',$itemid)"/>
  <tr>
    <td colspan="11">
        <table id="{$tblid}" cellspacing="0" cellpadding="2" border="0" frame="border" style="display:none" width="100%" class="PSTEXT">
            <tr valign="center" align="left">
                <xsl:for-each select="../secondary_key">
                <td class="PSLEVEL1GRIDCOLUMNHDR"><xsl:value-of select="."/></td>
                </xsl:for-each>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Attribute</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Old Release</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">New Release</td>
                <td class="PSLEVEL1GRIDCOLUMNHDR">Customization</td>
            </tr>

                <xsl:for-each select="secondary_key">
                <xsl:variable name="secondary_keyposition" select="position()"/>

                <xsl:variable name="rowclass2">
                    <xsl:choose>
                        <xsl:when test="position() mod 2=0">
                            PSLEVEL1GRIDEVENROWx
                        </xsl:when>
                        <xsl:otherwise>
                            PSLEVEL1GRIDODDROWx
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:variable>

            <tr>
                <xsl:for-each select="value">
                    <td class="{$rowclass2}"><xsl:value-of select="."/></td>
                </xsl:for-each>
                <xsl:variable name="value" select="value"/>
            </tr>

        <xsl:for-each select="attribute">
                <xsl:variable name="attribname" select="@name"/>
                <xsl:variable name="cSource" select="@diff"/>
                <xsl:variable name="atitletext" select="concat('Hide all [', $attribname, '] attributes')"/>
                <xsl:variable name="attribid" select="concat($secondary_keyposition,$itemid,$value,position(),$attribname)"/>
                <xsl:variable name="atitletext1" select="concat('Hide this attribute',' ')"/>

            <tr   id="{$attribid}" name="{$attribname}">
                <xsl:for-each select="../value">
                    <td class="{$rowclass2}"></td>
                </xsl:for-each>
                <td  class="{$rowclass2}"><xsl:value-of select="@name"/></td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="OldRelease"/></td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="NewRelease"/></td>
                <td  class="{$rowclass2}"><xsl:value-of disable-output-escaping="yes" select="Customization"/></td>
            </tr>
        </xsl:for-each>
    </xsl:for-each>
  </table>
  </td></tr>

<!-- </xsl:if> -->
</xsl:template>


<!-- EOF -->
</xsl:stylesheet>
