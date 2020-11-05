<?xml version='1.0'?>
<!-- 
 * itemSearch.xsl
 * This page is used to format the the search result
 * This xsl is being called from result.html
 * It expects a parameter from the JS method for Item ID
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="html"/>
<xsl:param name="js_param1"/>
<xsl:param name="js_param2"/>
<xsl:param name="js_param3"/>

<xsl:template match="/">

  <xsl:apply-templates select="/project/object_type" mode="keylist" />

</xsl:template>


<!-- Object names per type, mode = "keylist" -->

<xsl:template match="/project/object_type" mode="keylist">
<!-- Object Type Name table -->
<table id="primary" border="0" cellspacing="0" cellpadding="1" cols="1" width="100%" class="PSLEVEL1GRID">
    <tr class="PSLEVEL1GRIDLABEL">
        <td align="left">Item Details </td>
        <td align="left">
            <a href="#" onClick="ExpandAll()" class="PSHYPERLINKHEADER">
            <img src="../source/images/EXPAND.gif" border="0"/>Expand All </a>&#160;
            <a href="#" onClick="CollapseAll()" class="PSHYPERLINKHEADER">
            <img src="../source/images/COLLAPSE.gif" border="0"/>Collapse All</a>&#160;
            <a href="#" onClick="ShowAllAttributes()" class="PSHYPERLINKHEADER">
            <img src="../source/images/SHOW_ALL.gif" border="0"/>Show All Attributes</a>
	</td>
        <td align="right">
        <xsl:if test="($js_param2='CATemplate')">
            Customer Added
        </xsl:if>
        <xsl:if test="($js_param2='CMTemplate')">
            Customer Modified
        </xsl:if>
        <xsl:if test="($js_param2='PDTemplate')">
            PeopleSoft Deleted 
        </xsl:if>
        <xsl:if test="($js_param2='PATemplate')">
            PeopleSoft Added
        </xsl:if>
        <xsl:if test="($js_param2='PMTemplate')">
            PeopleSoft Modified 
        </xsl:if>
        </td>

    </tr>
</table>
<table border="1" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID">
    <tr>
        <td>
            <!-- Object name rows -->
            <!-- column headers -->
            <table border="0" cellspacing="0" cellpadding="0" style="border-style:none;" width="100%" class="PSTEXT" id="outertbl">
                <tr valign="center" align="left"> 
                    <xsl:for-each select="primary_key">
                        <td class="PSLEVEL1GRIDCOLUMNHDR"><xsl:value-of select="."/></td>
                    </xsl:for-each>
                    <td class="PSLEVEL1GRIDCOLUMNHDR">Source</td>
                    <td class="PSLEVEL1GRIDCOLUMNHDR">Target</td>
                    <td class="PSLEVEL1GRIDCOLUMNHDR">Action</td>
                    <td class="PSLEVEL1GRIDCOLUMNHDR">Upgrade</td>
                </tr>
                <xsl:apply-templates select="//item[starts-with(@id,$js_param1)]" mode="keylistA" />
    <tr>
        <td colspan="10">
	<table border="0" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID" id="elements">
    	<!-- Item List -->
        <xsl:variable name="checkCode" select="/project/object_type/@code"/>
	<xsl:if test="($js_param3='composite')">
        	<xsl:if test="($checkCode='true')">
            		<xsl:apply-templates select="//item[starts-with(@id,$js_param1)]" mode="Cmpkeylist" />
        	</xsl:if>
        	<xsl:if test="($checkCode='false')">
            		<xsl:apply-templates select="//item[starts-with(@id,$js_param1)]" mode="CmpkeylistB" />
        	</xsl:if>
        </xsl:if>
       	<xsl:if test="(not($js_param3='composite'))"> 
        	<xsl:if test="($checkCode='true')">
            		<xsl:apply-templates select="//item[starts-with(@id,$js_param1)]" mode="keylist" />
        	</xsl:if>
        	<xsl:if test="($checkCode='false')">
            		<xsl:apply-templates select="//item[starts-with(@id,$js_param1)]" mode="keylistB" />
        	</xsl:if>
        </xsl:if>
	</table>

        </td>
    </tr>

    </table>
        </td>
    </tr>
</table>
<table id="tertiary" border="0" cellspacing="0" cellpadding="2" cols="1" width="100%" class="PSLEVEL1GRID">
   <tr class="PSLEVEL1GRIDLABEL">
        <xsl:variable name="objtypename" select="@name"/>
        <td align="left">
            <a href="view_summary.html?objtype={$objtypename}?Template={$js_param2}" >Search Result</a>
        </td>
        <td align="right">Run Date: 
            <xsl:value-of select="/project/rundate"/>
        </td>
   </tr>
</table>
<p></p>
</xsl:template>

<!-- list by object name primary keys -->
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
           <xsl:value-of select="."/>
       </td>
        </xsl:for-each>
	<td class="{$rowclass}"><xsl:value-of select="source_status" /></td>
	<td class="{$rowclass}"><xsl:value-of select="target_status" /></td>
	<td class="{$rowclass}"><xsl:value-of select="action" /></td>
	<td class="{$rowclass}"><xsl:value-of select="upgrade" /></td>
    </tr>
</xsl:template>

<xsl:template match="item" mode="keylist">
    <xsl:variable name="objtypename" select="../@name"/>
    <xsl:variable name="itemid" select="@id"/>

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
        <tr>
            <xsl:for-each select="value">
                <td><xsl:value-of select="."/></td>
            </xsl:for-each>
            <xsl:variable name="value" select="value"/>
        </tr>

        <xsl:for-each select="attribute">
            <xsl:variable name="attribname" select="@name"/>
            <xsl:variable name="cSource" select="@diff"/>
            <xsl:variable name="atitletext" select="concat('Hide all [', $attribname, '] attributes')"/>
            <xsl:variable name="attribid" select="concat($itemid,$value,position(),$attribname)"/>
            <xsl:variable name="atitletext1" select="concat('Hide this attribute',' ')"/>

            <tr   id="{$attribid}" name="{$attribname}">
                <xsl:for-each select="../value">
                    <td></td>
                </xsl:for-each>
                <td><xsl:value-of select="@name"/></td>
                <td><xsl:value-of disable-output-escaping="yes" select="source"/></td>
                <td>
                <xsl:if test="($cSource='same')"></xsl:if>
                <xsl:if test="($cSource='targetonly')">
                <img src="../source/images/RIGHT_ARROW.gif" width="16" height="16" border="0"/> 
                </xsl:if>
                <xsl:if test="($cSource='sourceonly')">
                <img src="../source/images/LEFT_ARROW.gif" width="16" height="16" border="0"/> 
                </xsl:if>
                </td>
                <td><xsl:value-of disable-output-escaping="yes" select="target"/></td>
            </tr>
        </xsl:for-each>
    </xsl:for-each>
</xsl:template>

<xsl:template match="item" mode="keylistB">
    <xsl:variable name="objtypename" select="../@name"/>
    <xsl:variable name="itemid" select="@id"/>

    <tr valign="center" align="left">
        <xsl:for-each select="../secondary_key">
            <td class="PSLEVEL1GRIDCOLUMNHDR"><xsl:value-of select="."/></td>
        </xsl:for-each>
        <td class="PSLEVEL1GRIDCOLUMNHDR">Attribute</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR">Source</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR">Target</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR"></td>
        <td class="PSLEVEL1GRIDCOLUMNHDR"></td>
    </tr>

    <xsl:for-each select="secondary_key">
        <tr>
            <xsl:for-each select="value">
                <td><xsl:value-of select="."/></td>
            </xsl:for-each>
            <xsl:variable name="value" select="value"/>
        </tr>

        <xsl:for-each select="attribute">
            <xsl:variable name="seckey_value" select="../value"/>
	    <xsl:variable name="attribname" select="@name"/>
            <xsl:variable name="atitletext" select="concat('Hide all [', $attribname, '] attributes')"/>
            <xsl:variable name="attribid" select="concat($itemid , $seckey_value, position(), $attribname)"/>  
            <xsl:variable name="atitletext1" select="concat('Hide this attribute',' ')"/>

            <tr   id="{$attribid}" name="{$attribname}">
                <xsl:for-each select="../value">
                    <td></td>
                </xsl:for-each>
                <td><xsl:value-of select="@name"/></td>
                <td><xsl:value-of disable-output-escaping="yes" select="source"/></td>
                <td><xsl:value-of disable-output-escaping="yes" select="target"/></td>
                <td width="6%">
                    <a href="javascript:HideAttribute('{$attribid}');" title="{$atitletext1}">
                    <img src="../source/images/HIDE.gif" width="9" height="9" border="0"/></a>
                </td>
                <td width="6%"> 
                    <a href="javascript:HideAttributes('{$attribname}');" title="{$atitletext}">
                    <img src="../source/images/HIDEALL.gif" width="16" height="16" border="0"/> </a>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:for-each>
</xsl:template>

<xsl:template match="item" mode="Cmpkeylist">
    <xsl:variable name="objtypename" select="../@name"/>
    <xsl:variable name="itemid" select="@id"/>

    <tr valign="center" align="left">
        <xsl:for-each select="../secondary_key">
            <td class="PSLEVEL1GRIDCOLUMNHDR"><xsl:value-of select="."/></td>
        </xsl:for-each>
        <td class="PSLEVEL1GRIDCOLUMNHDR">Attribute</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR">Old Release</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR">New Release</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR">Customization</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR"></td>
        <td class="PSLEVEL1GRIDCOLUMNHDR"></td>
    </tr>

    <xsl:for-each select="secondary_key">
        <tr>
            <xsl:for-each select="value">
                <td><xsl:value-of select="."/></td>
            </xsl:for-each>
            <xsl:variable name="value" select="value"/>
        </tr>

        <xsl:for-each select="attribute">
            <xsl:variable name="attribname" select="@name"/>
            <xsl:variable name="cSource" select="@diff"/>
            <xsl:variable name="atitletext" select="concat('Hide all [', $attribname, '] attributes')"/>
            <xsl:variable name="attribid" select="concat($itemid,$value,position(),$attribname)"/>
            <xsl:variable name="atitletext1" select="concat('Hide this attribute',' ')"/>

            <tr   id="{$attribid}" name="{$attribname}">
                <xsl:for-each select="../value">
                    <td></td>
                </xsl:for-each>
                <td><xsl:value-of select="@name"/></td>
                <td><xsl:value-of disable-output-escaping="yes" select="OldRelease"/></td>
                <td><xsl:value-of disable-output-escaping="yes" select="NewRelease"/></td>
                <td><xsl:value-of disable-output-escaping="yes" select="Customization"/></td>
            </tr>
        </xsl:for-each>
    </xsl:for-each>
</xsl:template>

<xsl:template match="item" mode="CmpkeylistB">
    <xsl:variable name="objtypename" select="../@name"/>
    <xsl:variable name="itemid" select="@id"/>

    <tr valign="center" align="left">
        <xsl:for-each select="../secondary_key">
            <td class="PSLEVEL1GRIDCOLUMNHDR"><xsl:value-of select="."/></td>
        </xsl:for-each>
        <td class="PSLEVEL1GRIDCOLUMNHDR">Attribute</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR">Old Release</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR">New Release</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR">Customization</td>
        <td class="PSLEVEL1GRIDCOLUMNHDR"></td>
        <td class="PSLEVEL1GRIDCOLUMNHDR"></td>
    </tr>

    <xsl:for-each select="secondary_key">
        <tr>
            <xsl:for-each select="value">
                <td><xsl:value-of select="."/></td>
            </xsl:for-each>
            <xsl:variable name="value" select="value"/>
        </tr>

        <xsl:for-each select="attribute">
            <xsl:variable name="attribname" select="@name"/>
            <xsl:variable name="atitletext" select="concat('Hide all [', $attribname, '] attributes')"/>
            <xsl:variable name="attribid" select="concat($itemid,$value,position(),$attribname)"/>
            <xsl:variable name="atitletext1" select="concat('Hide this attribute',' ')"/>

            <tr   id="{$attribid}" name="{$attribname}">
                <xsl:for-each select="../value">
                    <td></td>
                </xsl:for-each>
                <td><xsl:value-of select="@name"/></td>
                <td><xsl:value-of disable-output-escaping="yes" select="OldRelease"/></td>
                <td><xsl:value-of disable-output-escaping="yes" select="NewRelease"/></td>
                <td><xsl:value-of disable-output-escaping="yes" select="Customization"/></td>
                <td width="2%">
                    <a href="javascript:HideAttribute('{$attribid}');" title="{$atitletext1}">
                    <img src="../source/images/HIDE.gif" width="9" height="9" border="0"/></a>
                </td>
                <td width="2%"> 
                    <a href="javascript:HideAttributes('{$attribname}');" title="{$atitletext}">
                    <img src="../source/images/HIDEALL.gif" width="16" height="16" border="0"/> </a>
                </td>
            </tr>
        </xsl:for-each>
    </xsl:for-each>
</xsl:template>

<!-- EOF -->
</xsl:stylesheet>
