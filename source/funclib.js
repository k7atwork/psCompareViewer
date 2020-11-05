//* *************************************************************** 
//*  This software and related documentation are provided under a   
//*  license agreement containing restrictions on use and           
//*  disclosure and are protected by intellectual property          
//*  laws. Except as expressly permitted in your license agreement  
//*  or allowed by law, you may not use, copy, reproduce,           
//*  translate, broadcast, modify, license, transmit, distribute,   
//*  exhibit, perform, publish or display any part, in any form or  
//*  by any means. Reverse engineering, disassembly, or             
//*  decompilation of this software, unless required by law for     
//*  interoperability, is prohibited.                               
//*  The information contained herein is subject to change without  
//*  notice and is not warranted to be error-free. If you find any  
//*  errors, please report them to us in writing.                   
//*                                                                 
//*  Copyright (C) 1988, 2012, Oracle and/or its affiliates.        
//*  All Rights Reserved.                                           
//* *************************************************************** 
 
//*                                                                    
/***********************************************************************
*                                                                      *
*       funclib.js  -- Compare Viewer JS implementation file *
*                                                                      *
************************************************************************
*                                                                      *
*                                                                      *
************************************************************************
*                                                                      *
*                    /pt_install/SETUP/UPGCOMPVIEWER/report_files/source/funcli
*                     /main/pt84x/4
* $Author:: crajase$crajasek
* $Date:: 5-Nov-2$1-Nov-2004.12:10:24
***********************************************************************/

var _IS_IE11 = (navigator.userAgent.match(/Trident.*rv[ :]*11\./))?true:false;
var _SARISSA_HAS_DOM_IMPLEMENTATION = document.implementation && true;
var _SARISSA_HAS_DOM_CREATE_DOCUMENT = (_SARISSA_HAS_DOM_IMPLEMENTATION && document.implementation.createDocument)?true:false;
var _SARISSA_HAS_DOM_FEATURE = (_SARISSA_HAS_DOM_IMPLEMENTATION && document.implementation.hasFeature)?true:false;
var _SARISSA_IS_MOZ = (_SARISSA_HAS_DOM_CREATE_DOCUMENT && _SARISSA_HAS_DOM_FEATURE )?true:false;
var _SARISSA_IS_IE = (document.all && (navigator.userAgent.indexOf('MSIE') !== -1 || navigator.appVersion.indexOf('Trident/') > 0))?true:false;
var _SARISSA_IS_IE9 = (_SARISSA_IS_IE && navigator.userAgent.toLowerCase().indexOf("msie 9") > -1)?true:false;
var _IS_CHROME = (navigator.userAgent.toLowerCase().indexOf('chrome') > -1)?true:false;

function getCompareFlag()
{
    var args = getArgs();
    var objType = null;
    var rptType = null;
    if (args.objtype) objType = args.objtype;

    if (args.rpttype) rptType = args.rpttype;
    
    if (!rptType) {
        if (!parent.selectedTab)
              parent.selectedTab = "compare";
    }
    
    if(rptType)
        parent.selectedTab = rptType;
    
    
    return parent.selectedTab;
 }


/*
***********************************************************************
* searchResult function

* No Paremeters are being passed

* This function checks and gives input for display of search results

* - alertMessage : This alert message is displayed if the user fails 
    to enter required number of characters in the search text.
  - item_id : This determines the text user has entered
  - objType : This determines the record user has selected  
  - xmlDocObject : Instance of XML document
  - xmlDoc : complete path of XML file
  - filter : Filter criteria for XPATH selector
  - oNodeList: Nodelist generated after selection accorind to 
    XPATH filter criteria
  - objTd.innerText: Inner Text for the second table/td on Search.html
  - pageId : absolute pageid where the search item resides
    
************************************************************************
*/

function searchResult()
{   
    if (document.search.search_text.value.length < 3)
    {
        var alertMessage="Search text requires at least three characters";
        if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11){
            objTd.innerText=alertMessage;
        }else {
            document.getElementById("objTd").innerText = alertMessage;
        }
        return false;
    }
    var item_id = document.search.search_text.value;
    var box     = document.search.search_list;
    if (box.options[box.selectedIndex].value=='N/A')
    {
        var alertMessage="Please select the definition type";
        if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11){
            objTd.innerText=alertMessage;
        }else {
            document.getElementById("objTd").innerText = alertMessage;
        }
        return false;
    }
    var objType = box.options[box.selectedIndex].text;

    switch(objType)
    {
        case "Colors" :
        break;
        case "Styles" :
        break;
        case "Activities" :
        break;
        case "Roles" :
        break;
        case "Process Definitions" :
        break;
        case "Process Type Definitions" :
        break;
        case "Recurrance Definitions" :
        break;
        case "Approval Rule Sets" :
        break;
        case "Business Processes" :
        break;

        default : 
        item_id=item_id.toUpperCase();  // in case of lowercase characters
        break;
    }
    
    var pageId;
    
    var xmlDocObject = Sarissa.getDomDocument();
    xmlDocObject.async = false;
    
    xmlDocObject.load(objType+"/index.xml");
    xmlDocObject.setProperty("SelectionLanguage", "XPath");
    var filter="//item[starts-with(@id,'"+item_id+"')]";
    var oNodeList = xmlDocObject.selectNodes(filter);

    for (var i=0;i < oNodeList.length;i++)
    {
        pageId = oNodeList.item(i).getAttribute("page");
        break;
    }
    var xmlDoc = objType+"/"+objType+"_"+pageId+".xml";
        
    if (parent.hasComposite > 0)
    {
            var cmpXmlDocObject = Sarissa.getDomDocument();
            cmpXmlDocObject.async = false;
            
            cmpXmlDocObject.load(objType+"/cmp_index.xml");
            cmpXmlDocObject.setProperty("SelectionLanguage", "XPath");
            var cmpFilter="//item[starts-with(@id,'"+item_id+"')]";
            var cmpONodeList = cmpXmlDocObject.selectNodes(cmpFilter);
        
            for (var i=0;i < cmpONodeList.length;i++)
            {
                cmpPageId = cmpONodeList.item(i).getAttribute("page");
                break;
            }
        
            var cmpXmlDoc = objType+"/cmp_"+objType+"_"+pageId+".xml";
            
            if (oNodeList.length > 0 && cmpONodeList.length > 0)
            {
                location.replace('searchDisplay.html?xsl=itemSearch.xsl?xml='+xmlDoc+'?cmpxml='+cmpXmlDoc+'?item_id='+item_id+'');
            }
            else
            {
                document.getElementById("objTd").innerText="No Items Found";
                return false;
            }
        
        }
        else
        {
            if (oNodeList.length>0) {
                location.replace('searchDisplay.html?xsl=itemSearch.xsl?xml='+xmlDoc+'?item_id='+item_id+'');
            }else{
                document.getElementById("objTd").innerText="No Items Found";
                return false;
            }
        }
}

/*
***********************************************************************
* search function

* Takes three parameters 
    xsl     : Input XSL file
    xmlDoc  : Input XML file
    item_id : Input paremeter based on which the search will be filtered
* This function populates the viewarea frame with the search results
* sResult : Result after processing appropriate XML/XML and required 
  parameter as required for IE or Netscape
* Called onLoad of result.html to populate viewarea with the search results
************************************************************************
*/

function search(xsl,xmlDoc,item_id)
{
    if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        var sResult = getResultIE(xsl,xmlDoc,item_id);      
        document.getElementById("divSearch").innerHTML= sResult;
    }else{
    
        // transform and store the results to a DOM
        var sResult = getResultNetscape(xsl,xmlDoc,item_id);
        document.getElementById("divSearch").appendChild(sResult);
    }
}

function searchDisplay(xsl,xmlDoc,cmpXmlDoc, item_id)
{
    var rptType = '';
    rptType = getCompareFlag();
    var turl = "searchDisplay.html?xsl=itemSearch.xsl?xml="+xmlDoc+
                "?cmpxml="+cmpXmlDoc+"?item_id="+item_id;
        
    if (parent.hasComposite > 0)
    {
        var tab = '<div id="header">' + '<ul id="primary">';
        if (parent.selectedTab == "composite")
        {
            tab = tab + '<li><a href="' + turl + '?rpttype=compare"' + 
                    ' target="viewarea">Compare Report</a></li>' +
                    '<li><span>Composite Report</span></li> ';
            xmlDoc = cmpXmlDoc;
        }
        else
        {
            tab = tab + '<li><span>Compare Report</span></li> ' +
                    '<li><a href="' + turl + '?rpttype=composite" ' + 
                    'target="viewarea">Composite Report</a></li> ';
        }
        tab = tab + '</ul>' + '</div>';
    }
    
    if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        var sResult = getResultIE2(xsl,xmlDoc,item_id, rptType);      
        document.getElementById("divSearch").innerHTML= sResult;
        if (parent.hasComposite > 0)
            document.getElementById("header").innerHTML = tab;
    }else{
    
        // transform and store the results to a DOM
        var sResult = getResultNetscape2(xsl,xmlDoc,item_id, rptType);
        document.getElementById("divSearch").appendChild(sResult);        
        // TODO: TEST on different Browsers;
        if (parent.hasComposite > 0)
            document.getElementById("header").innerHTML=tab;

    }
}

function search_summary(xsl,xmlDoc,cmpXmlDoc,item_id,Template)
{
    var rptType = '';
    rptType = getCompareFlag();
    var turl = "resultSummary.html?xsl=summaryItemSearch.xsl?xml="+xmlDoc+
                "?cmpxml="+cmpXmlDoc+"?item_id="+item_id+"?Template="+Template;
        
       
    if (parent.hasComposite > 0)
    {
        var tab = '<div id="header">' + '<ul id="primary">';
        if (parent.selectedTab == "composite")
        {
            tab = tab + '<li><a href="' + turl + '?rpttype=compare"' + 
                    ' target="viewarea">Compare Report</a></li>' +
                    '<li><span>Composite Report</span></li> ';
            xmlDoc = cmpXmlDoc;
        }
        else
        {
            tab = tab + '<li><span>Compare Report</span></li> ' +
                    '<li><a href="' + turl + '?rpttype=composite" ' + 
                    'target="viewarea">Composite Report</a></li> ';
        }
        tab = tab + '</ul>' + '</div>';
    }
    
   
    if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        var sResult = getResultIE_Paging(xsl,xmlDoc,item_id, Template, rptType);       
        document.getElementById("divSearch").innerHTML= sResult;
        if (parent.hasComposite > 0)
            document.getElementById("header").innerHTML = tab;
        
    }else{
    
        // transform and store the results to a DOM
        var sResult = getResultNetscape_Paging(xsl,xmlDoc,item_id, Template, rptType);
        //document.getElementById("divSearch").appendChild(sResult);
		document.getElementById("divSearch").appendChild(sResult.ownerDocument.importNode(sResult, true));
        if (parent.hasComposite > 0)
            document.getElementById("header").innerHTML = tab;
    }
}
function summaryItemSelect (objType,item_id, Template)
{
    var xmlDocObject = Sarissa.getDomDocument();
    xmlDocObject.async = false;
    xmlDocObject.load(objType+"/index.xml");
    xmlDocObject.setProperty("SelectionLanguage", "XPath");
    var filter="//item[@id='"+item_id+"']";
    var oNode = xmlDocObject.selectSingleNode(filter);
    var pageId;
    pageId = oNode.getAttribute("page");
    var xmlDoc = objType+"/"+objType+"_"+pageId+".xml";
    if (parent.hasComposite > 0)
    {
        var cmpXmlDocObject = Sarissa.getDomDocument();
        cmpXmlDocObject.async = false;
        cmpXmlDocObject.load(objType+"/cmp_index.xml");
        cmpXmlDocObject.setProperty("SelectionLanguage", "XPath");
        var cmpFilter="//item[@id='"+item_id+"']";
        var cmpONode = xmlDocObject.selectSingleNode(filter);
        var cmpPageId;
        cmpPageId = oNode.getAttribute("page");
        var cmpXmlDoc = objType+"/cmp_"+objType+"_"+pageId+".xml";
    }

    location.replace('resultSummary.html?xsl=summaryItemSearch.xsl?xml='+xmlDoc+'?item_id='+item_id+'?Template='+Template+'?cmpxml='+ cmpXmlDoc+'');
}
/*
***********************************************************************
* ObjectTypeList function

* Parameters Nill

* This function populates the side bar.
* sResult : Result after processing appropriate XML/XML and required 
  parameter as required for IE or Netscape
* Called from OnLoad objtypelist.html to populate Definition Types list 
  of available reports from project.xml
************************************************************************
*/

function ObjectTypeList()
{
    if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        // transform and store the results to a string
        var sResult = getResultIE('objtypes.xsl','project.xml','');     
        document.getElementById("divObjtypeList").innerHTML = sResult;
    }else{

        // transform and store the results to a DOM
        var sResult = getResultNetscape("objtypes.xsl","project.xml",'');
        document.getElementById("divObjtypeList").appendChild(sResult);
    }
}

/*
***********************************************************************
* PrintHeader function

* Parameters Nill

* This function populates the header
* sResult : Result after processing appropriate XML/XML and required 
  parameter as required for IE or Netscape
* Called from OnLoad header.html to populate header attributes from project.xml
************************************************************************
*/

function statusSummary()
{
   if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        // transform and store the results to a string
        var sResult = getResultIE('status.xsl','project.xml','');       
        document.getElementById("divStatusSummary").innerHTML = sResult;
    }else{

        // transform and store the results to a DOM
        var sResult = getResultNetscape("status.xsl","project.xml",'');
        document.getElementById("divStatusSummary").appendChild(sResult);
    }
    var xmlDocObject = Sarissa.getDomDocument();
    xmlDocObject.async = false;
    xmlDocObject.load("project.xml");
    xmlDocObject.setProperty("SelectionLanguage", "XPath");
    var oNodeList = xmlDocObject.selectNodes("//project/object_type/@name");
    var counterATD = 0;
    var counterBTD = 0;
    var counterCTD = 0;
    var counterDTD = 0;
    var counterETD = 0;

    for (var i=0;i < oNodeList.length;i++)
    {
        var oNode = oNodeList.item(i).value;
        var aTDValue = parseInt(document.getElementById("A_"+oNode).innerText);
        counterATD  = counterATD+aTDValue;

        var bTDValue = parseInt(document.getElementById("B_"+oNode).innerText);
        counterBTD  = counterBTD+bTDValue;
        
        var cTDValue = parseInt(document.getElementById("C_"+oNode).innerText);
        counterCTD  = counterCTD+cTDValue;
        
        var dTDValue = parseInt(document.getElementById("D_"+oNode).innerText);
        counterDTD  = counterDTD+dTDValue;
        
        var eTDValue = parseInt(document.getElementById("E_"+oNode).innerText);
        counterETD  = counterETD+eTDValue;
    }
    document.getElementById("CA").innerText = counterATD;
    document.getElementById("CM").innerText = counterBTD;
    document.getElementById("CD").innerText = counterCTD;
    document.getElementById("PA").innerText = counterDTD;
    document.getElementById("PM").innerText = counterETD;
}

/*
***********************************************************************
* SummaryObjectTypeSelect function

* objType   :  Absolute directory of records

* This function populates the viewarea based on the objecttype 
  selected from definition type list 
* - xmlDoc : complete path of XML file
  - sResult : Result after processing appropriate XML/XML and required 
    parameter as required for IE or Netscape
* Called from OnLoad ViewArea.html to populate viewarea, 
  with the report from the selected Object Name .XML file
************************************************************************
*/

function SummaryObjectTypeSelect(objType,template,filecount)
{
    var xslDoc ="summaryItems.xsl";
    window.status="Please wait ...";
    var totalItemCount = getItemCount(objType); 
    var xmlDoc = objType+"/"+"index.xml";
  
    var totalItemCount = getItemCount(objType); 

    // This loop would be called for Microsoft Internet Explorer
    if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        var sResult = getResultIE(xslDoc,xmlDoc,template);
        document.getElementById("divSummaryItemsList").innerHTML = sResult;
        window.status="Done";

    }else{    
        // This loop would be called for Netscape or 
        // Other mozilla compatible browsers 
        var oResult = getResultNetscape(xslDoc,xmlDoc,template);
        document.getElementById("divSummaryItemsList").appendChild(oResult);
        window.status="Done";
    }
}


/*
***********************************************************************
* PrintHeader function

* Parameters Nill

* This function populates the header
* sResult : Result after processing appropriate XML/XML and required 
  parameter as required for IE or Netscape
* Called from OnLoad header.html to populate header attributes from project.xml
************************************************************************
*/

function PrintHeader()
{
    var rptType = getCompareFlag();

    if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        if (parent.hasComposite == -1) {
            // transform and store the results to a string
            var sResult = getResultIE('header.xsl','project.xml','');
        } else {
          // transform and store the results to a string
            var sResult = getResultIE2('header.xsl','project.xml', '', rptType);
        }
        /* TODO: find a better way of detecting project.xml contains composite 
        ** report node. We need to check for the node to display tabs or not.
        **
        */
        parent.hasComposite = sResult.indexOf("id=\"header\"");
        document.getElementById("divReportHeader").innerHTML = sResult;
    }else{
    
        if (parent.hasComposite == -1) {
           // transform and store the results to a DOM
            var sResult = getResultNetscape("header.xsl","project.xml",'');
        } else {
       // transform and store the results to a DOM
            var sResult = getResultNetscape2("header.xsl","project.xml", '', rptType);
        }
        /* TODO: find a better way of detecting project.xml contains composite 
        ** report node. We need to check for the node to display tabs or not.
        **
        */
        parent.hasComposite = sResult.xml.indexOf("id=\"header\"");
        document.getElementById("divReportHeader").appendChild(sResult);
    }
}

/*
***********************************************************************
* ObjectTypeSelect function

* ObjectTypeName: Absolute file name to browse
  objType   :  Absolute directory of records

* This function populates the viewarea based on the objecttype 
  selected from definition type list 
* - xmlDoc : complete path of XML file
  - sResult : Result after processing appropriate XML/XML and required 
    parameter as required for IE or Netscape
* Called from OnLoad ViewArea.html to populate viewarea, 
  with the report from the selected Object Name .XML file
************************************************************************
*/

function ObjectTypeSelect(ObjectTypeName,objType, totalPages, page)
{
    var xslDoc ="items.xsl";
    var page = page;
    var xmlDoc = objType+"/"+ObjectTypeName+".xml";
    
    var cmpXmlDoc = objType + "/cmp_" + ObjectTypeName + ".xml";
    
    var rptType = getCompareFlag();
    
    var fileCount = getFileCount(objType, rptType);
    var totalItemCount = getItemCount(objType, rptType); 
   
   
    if (parent.selectedTab != "compare") {
        xmlDoc = cmpXmlDoc;
    }
    
    // This loop would be called for Microsoft Internet Explorer
    if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        window.status="Please wait ...";
       if (fileCount != null) {
       var sResult = getResultIE2(xslDoc,xmlDoc,totalItemCount, rptType);
         document.getElementById("divItemsList").innerHTML = sResult;
        
         var pageResult = getResultIE_Paging("itemtypeheader.xsl",xmlDoc,page,totalItemCount,fileCount);
         document.getElementById("paging").innerHTML = pageResult;
       } else {
           document.getElementById("divItemsList").innerHTML = "<div id=error><br></br>Composite Report Unavailable</div>";
       }
       
       window.status="Done";

    }else{
    
   
        // This loop would be called for Netscape or 
        // Other mozilla compatible browsers 
        window.status="Please wait ...";
        if (fileCount != null) {
        var oResult = getResultNetscape2(xslDoc,xmlDoc,totalItemCount, rptType);
        AddNode(document.getElementById("divItemsList"), oResult);
        var pageResultNetscape = getResultNetscape_Paging("itemtypeheader.xsl",xmlDoc,page,totalItemCount,fileCount);
        AddNode(document.getElementById("paging"), pageResultNetscape);
        } else {
           document.getElementById("divItemsList").innerHTML = "<div id=error><br></br>Composite Report Unavailable</div>";
        }
        window.status="Done";
    }
}


/*
***********************************************************************
* AddNode function

* parentNode: Parent Document node
  newChild  :  child node to add

* This function adds the child node to parent node, if parent node already
  has a child node then it replaces the firstChild with the new child node.
* Called from ObjectTypeSelect to update the table with correct page on 
  Mozilla/Netscape
************************************************************************
*/
function AddNode(parentNode, newChild)
{
    if (parentNode.hasChildNodes())
    {
        parentNode.replaceChild(newChild, parentNode.firstChild);   
    
    }
    else
    {
        parentNode.appendChild(newChild);
    }
}

/*
***********************************************************************
* AddTabs function

* objType: Type of object for which tab is being added 
 
* This function adds tabs if project has composite report. Also
  defaults the tab to what user had selected in previous object view page
************************************************************************
*/

function AddTabs(objType)
{
    getCompareFlag();
    if (objType)
        taburl = "viewarea.html?objtype=" + objType;
    if (parent.hasComposite > 0)
    {
        document.write('<div id="header">' + '<ul id="primary">');
        if (parent.selectedTab == "composite")
        {
            document.write('<li><a href="' + taburl + '?rpttype=compare"' + 
            ' target="viewarea">Compare Report</a></li>' +
            '<li><span>Composite Report</span></li> ');
        }
        else
        {
            document.write('<li><span>Compare Report</span></li> ' +
            '<li><a href="' + taburl + '?rpttype=composite" ' + 
            'target="viewarea">Composite Report</a></li> ');
        }
        document.write('</ul>' + '</div>');
    }
    
}

/*
***********************************************************************
* ItemSelect function

* ObjectTypeName: Absolute object name to browse
  ItemID        : Absolute item id of object

* This function populates the viewarea with attributes attached to item id 
  selected from display 
* - xmlDoc : complete path of XML file
  - sResult : Result after processing appropriate XML/XML and required 
    parameter as required for IE or Netscape
************************************************************************
*/

function ItemSelect(ObjectTypeName, ItemID)
{
    var objItemNode;
    var tblId = "tbl" + ItemID;

    linkObj = document.getElementById(ItemID);

    // show or hide the inner attribute table
    
    styleObj = document.getElementById(tblId).style;
    if (styleObj.display=='none') 
    {
        // expand
        styleObj.display = '';
        linkObj.title = 'Collapse ' + ItemID;
    }
    else 
    {
        // collapse
        styleObj.display = 'none';
        linkObj.title = 'Expand ' + ItemID;
    }
}

/*
***********************************************************************
* HideAttributes function

* attribName: Absolute attribute name to browse

* This function populates the viewarea with attributes attached to item id 
  selected from display 
* - styleObj : style attribute from defaut CSS
  - attribs : List of table rows    
* Hide all the similar attributes
************************************************************************
*/

function HideAttributes(attribName)
{
    // called from items.xsl, when click on attribute name link
    // to hide all attributes for all item of this name
    
    window.status="Please wait ...";
    var attribs = document.getElementsByTagName("tr");

    for (var i = 0; i < attribs.length; i++)
    {
        
       if(attribs[i].getAttribute('name')==attribName)
        {
            var styleObj = attribs[i].style;
             styleObj.display = 'none';
        }
    }
    window.status="Done";
}

/*
***********************************************************************
* HideAttribute function

* attribid: Absolute attribute name to browse

* This function populates the viewarea with attributes attached to item id 
  selected from display 
* - styleObj : style attribute from defaut CSS
  - attribs : List of table rows    
* Hides a single attribute row
************************************************************************
*/

function HideAttribute(attribid)
{
    // called from items.xsl, when click on attribute name link
    // to hide the partcular attribute selected

    window.status="Please wait ...";
    var attribs = document.getElementById(attribid);
    var styleObj = attribs.style;
    styleObj.display = 'none';
    window.status="Done";
}

/*
***********************************************************************
* ExpandAll function
* - styleObj : style attribute from defaut CSS
  - attribs : List of table rows    
* This function expands all attribute inner tables 
************************************************************************
*/

function ExpandAll()
{
    window.status="Please wait ...";
    var tables = document.getElementsByTagName("table");
    for (var i = 0; i < tables.length; i++)
    {
        var styleObj = tables[i].style;
        styleObj.display = '';
    }
    window.status="Done";
}

/*
***********************************************************************
* CollapseAll function
* - styleObj : style attribute from defaut CSS
  - attrtbls : Gets the tables inside outer table
* This function collapses all attribute inner tables 
************************************************************************
*/

function CollapseAll()
{
    // Collapse All button
    // to collapse all attribute inner tables
    window.status="Please wait ...";
    var outertbl = document.getElementById("outertbl");
    var attrtbls = outertbl.getElementsByTagName("table");
    for (var i = 0; i < attrtbls.length; i++)
    {
        var styleObj = attrtbls[i].style;
        styleObj.display = 'none';
    }
    window.status="Done";
}

/*
***********************************************************************
* ShowAllAttributes function
* - styleObj : style attribute from defaut CSS
  - attrtbls : Gets the tables inside outer table
* This function show all attribute names hidden by HideAttributes
************************************************************************
*/

function ShowAllAttributes()
{
    var outertbl = document.getElementById("outertbl");
    var attrtbls = outertbl.getElementsByTagName("tr");
    for (var i = 0; i < attrtbls.length; i++)
    {
        var styleObj = attrtbls[i].style;
        styleObj.display = '';
    }
}

/*
*************************************************************************
* getArgs function 
*************************************************************************
*/

function getArgs()
{
    var args = new Object();
    var query = location.search.substring(1);
    var pairs = query.split("?");
    for (var i = 0; i < pairs.length; i++)
    {
        var pos = pairs[i].indexOf('=');
        if (pos == -1) continue;
        var argname = pairs[i].substring(0,pos);
        var value = pairs[i].substring(pos+1);
        args[argname] = unescape(value);
    }
    return args;
}

/*
***********************************************************************
* projectTypeList function
* - sResult : Result after processing appropriate XML/XML and required 
    parameter as required for IE or Netscape
* This populates the poojects available in the release directory
************************************************************************
*/

function projectTypeList()
{
    //Add IE11 support
    if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        // transform and store the results to a string
        var sResult = getResultIE('projectList.xsl','projectList.xml','');      
        document.getElementById("divPrjtypeList").innerHTML = sResult;
    }else if ((_SARISSA_IS_MOZ) && (!_IS_CHROME))
    {
        // transform and store the results to a DOM
        var sResult = getResultNetscape("projectList.xsl","projectList.xml",'');
        document.getElementById("divPrjtypeList").appendChild(sResult);
    }else if (_IS_CHROME)
	{
	// transform and store the results to a DOM
    var sResult = getResultChrome("projectList.xsl","projectList.xml",'');
    document.getElementById("divPrjtypeList").appendChild(sResult);
	}
}

/*
***********************************************************************
* getResultIE function
* Takes three parameters 
    objectXslDoc    : Input XSL file
    objectXmlDoc    : Input XML file
    js_param        : Input paremeter based on which the search will be filter

*   - xmlDoc  : Instance of XML document
    - xslProc : Resulted processed XSL
    - sResult : Result after processing appropriate XML/XML and required 
    parameter as required for IE or Netscape
* This returns a translated documenent which can be directly 
  assigned to innerHTML area of the specified DIV
************************************************************************
*/
function getResultIE(objectXslDoc,objectXmlDoc,js_param)
{
    return getResultIE2(objectXslDoc,objectXmlDoc,js_param, '');
}
function getResultIE2(objectXslDoc,objectXmlDoc,js_param, js_param2)
{
    //Create the XSLTemplate object (xslt).
    var xslt = new ActiveXObject("Msxml2.XSLTemplate");

    //Create and load the stylesheet (e.g items.xsl) as a DOMDocument.
    var xslDoc = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");
    var xslProc;
    xslDoc.async = false;
    xslDoc.load(objectXslDoc);

    //Connect the XSLTemplate object to stylesheet DOMDocument.
    xslt.stylesheet = xslDoc;
    var xmlDoc = new ActiveXObject("Msxml2.DOMDocument");
    xmlDoc.async = false;
    xmlDoc.load(objectXmlDoc);
    
    //Create XSLT processor using stylesheet for XSL template.
    xslProc = xslt.createProcessor();
    xslProc.addParameter("js_param", js_param);
    xslProc.addParameter("js_param2", js_param2);

    //Assign XML file as input of the transform() method.
    xslProc.input = xmlDoc;

    //Do transformation on the XML file.
    xslProc.transform();
    var sResult = xslProc.output;       
    return sResult;
}

/*
***********************************************************************
* getResultNetscape function
* Takes three parameters 
    objectXslDoc    : Input XSL file
    objectXmlDoc    : Input XML file
    js_param        : Input paremeter based on which the search will be filter
*   - xmlDoc  : Instance of XML document
    - xslProc : Resulted processed XSL
    - sResult : Result after processing appropriate XML/XML and required 
    parameter as required for IE or Netscape
* This returns a translated documenent which can be directly 
  assigned to innerHTML area of the specified DIV
************************************************************************
*/

function getResultNetscape(objectXslDoc,objectXmlDoc,param)
{
    return getResultNetscape2(objectXslDoc,objectXmlDoc,param, '');
}

function getResultNetscape2(objectXslDoc,objectXmlDoc, param, param2)
{
    var xslStylesheet;
    var xmlDoc;
  
    //Create XSLT processor using stylesheet for XSL template.
    var xsltProcessor = new XSLTProcessor();

    // load the xslt file
    var myXMLHTTPRequest = new XMLHttpRequest();
    myXMLHTTPRequest.open("GET", objectXslDoc, false);
    myXMLHTTPRequest.send(null);
    xslStylesheet = myXMLHTTPRequest.responseXML;
    xsltProcessor.importStylesheet(xslStylesheet);

    // set the paraneters to xslt file
    xsltProcessor.setParameter(null, "js_param", param);
    xsltProcessor.setParameter(null, "js_param2", param2);

    var url = (window.location != window.parent.location)
            ? document.referrer
            : document.location.href;
    alert(url);
	
    // load the xml file
    myXMLHTTPRequest = new XMLHttpRequest();
    myXMLHTTPRequest.open("GET", objectXmlDoc, false);
    myXMLHTTPRequest.send(null);
    objectXmlDoc = myXMLHTTPRequest.responseXML;
    

   
    // Prepare a transformed content to be loaded as HTML
    var fragment = xsltProcessor.transformToFragment(objectXmlDoc, document);
    
    // Return the conntent to the called function 
    return fragment;
}

/*
***********************************************************************
* getResultChrome function
* Takes three parameters 
    objectXslDoc    : Input XSL file
    objectXmlDoc    : Input XML file
    js_param        : Input paremeter based on which the search will be filter
*   - xmlDoc  : Instance of XML document
    - xslProc : Resulted processed XSL
    - sResult : Result after processing appropriate XML/XML and required 
    parameter as required for IE or Netscape
* This returns a translated documenent which can be directly 
  assigned to innerHTML area of the specified DIV
************************************************************************
*/

function getResultChrome(objectXslDoc,objectXmlDoc,param)
{
    return getResultChrome2(objectXslDoc,objectXmlDoc,param, '');
}

function getResultChrome2(objectXslDoc,objectXmlDoc, param, param2)
{
    var xslStylesheet;
    var xmlDoc;
  
    //Create XSLT processor using stylesheet for XSL template.
    var xsltProcessor = new XSLTProcessor();

    // load the xslt file
    var myXMLHTTPRequest = new XMLHttpRequest();
    myXMLHTTPRequest.open("GET", objectXslDoc, false);
    myXMLHTTPRequest.send(null);
    xslStylesheet = myXMLHTTPRequest.responseXML;
    xsltProcessor.importStylesheet(xslStylesheet);

    // set the paraneters to xslt file
    xsltProcessor.setParameter(null, "js_param", param);
    xsltProcessor.setParameter(null, "js_param2", param2);

    // load the xml file
    myXMLHTTPRequest = new XMLHttpRequest();
    myXMLHTTPRequest.open("GET", objectXmlDoc, false);
    myXMLHTTPRequest.send(null);
    objectXmlDoc = myXMLHTTPRequest.responseXML;
    

   
    // Prepare a transformed content to be loaded as HTML
    var fragment = xsltProcessor.transformToFragment(objectXmlDoc, document);
    
    // Return the conntent to the called function 
    return fragment;
}
/*
***********************************************************************
* getCookie function
* name : name of cookie
* This creates a cookie : return string containing value of specified cookie 
  or null if cookie does not exist
************************************************************************
*/

function getCookie(name) {
  var dc = document.cookie;
  var prefix = name + "=";
  var begin = dc.indexOf("; " + prefix);
  if (begin == -1) {
    begin = dc.indexOf(prefix);
    if (begin != 0) return null;
  } else
    begin += 2;
  var end = document.cookie.indexOf(";", begin);
  if (end == -1)
    end = dc.length;
  return unescape(dc.substring(begin + prefix.length, end));
}

/*
***********************************************************************
* getexpirydate function
* nodays : number of days for expiry
* This creates a cookie : return string containing value of specified cookie 
  or null if cookie does not exist
************************************************************************
*/

function getexpirydate( nodays){
    var UTCstring;
    Today = new Date();
    nomilli=Date.parse(Today);
    Today.setTime(nomilli+nodays*24*60*60*1000);
    UTCstring = Today.toUTCString();
    return UTCstring;
}

function getFileCount(objType, type){

    var attr = "filecount";

    if (type == "composite")
        attr = "cmp_filecount";
        
    var xmlDoc = Sarissa.getDomDocument();
    xmlDoc.async = false;
    xmlDoc.load("project.xml");
    xmlDoc.setProperty("SelectionLanguage", "XPath");
    var filter="//object_type[@name='"+objType+"']";
    var oNodeList = xmlDoc.selectNodes(filter);
    var file_count;
    for (var i=0;i < oNodeList.length;i++){
        file_count = oNodeList.item(i).getAttribute(attr);
        break;
    }   
    return file_count;
}


function getItemCount(objType, type){

    var attr = "items";

    if (type == "composite")
        attr = "cmp_items";
    var xmlDoc = Sarissa.getDomDocument();
    xmlDoc.async = false;
    xmlDoc.load("project.xml");
    xmlDoc.setProperty("SelectionLanguage", "XPath");
    var filter="//object_type[@name='"+objType+"']";
    var oNodeList = xmlDoc.selectNodes(filter);
    var item_count;
    for (var i=0;i < oNodeList.length;i++){
        item_count = oNodeList.item(i).getAttribute(attr);
        break;
    }   
    return item_count;
}

function getItemCountPerPage(objType,objPageName){
    var attr = "items";

    if (type == "composite")
        attr = "cmp_items";

    var xmlDoc = Sarissa.getDomDocument();
    xmlDoc.async = false;
    xmlDoc.load(objType+"/"+objPageName+".xml");
    xmlDoc.setProperty("SelectionLanguage", "XPath");
    var filter="//object_type[@name='"+objType+"']";
    var oNodeList = xmlDoc.selectNodes(filter);
    var item_count;
    for (var i=0;i < oNodeList.length;i++){
        item_count = oNodeList.item(i).getAttribute(attrs);
        break;
    }   
    return item_count;
}

/*
***********************************************************************
* getResultIE function
* Takes three parameters 
    objectXslDoc    : Input XSL file
    objectXmlDoc    : Input XML file
    js_param        : Input paremeter based on which the search will be filter
    param1          : Javascript Parameter for XSL
    param2          : Javascript Parameter for XSL
    param3          : Javascript Parameter for XSL

*   - xmlDoc  : Instance of XML document
    - xslProc : Resulted processed XSL
    - sResult : Result after processing appropriate XML/XML and required 
    parameter as required for IE or Netscape
* This returns a translated documenent which can be directly 
  assigned to innerHTML area of the specified DIV
************************************************************************
*/

function getResultIE_Paging(objectXslDoc,objectXmlDoc,param1,param2,param3)
{
    //Create the XSLTemplate object (xslt).
    var xslt = new ActiveXObject("Msxml2.XSLTemplate");
    

    //Create and load the stylesheet (e.g items.xsl) as a DOMDocument.
    var xslDoc = new ActiveXObject("Msxml2.FreeThreadedDOMDocument");
    var xslProc;
    xslDoc.async = false;
    xslDoc.load(objectXslDoc);

    //Connect the XSLTemplate object to stylesheet DOMDocument.
    xslt.stylesheet = xslDoc;
    var xmlDoc = new ActiveXObject("Msxml2.DOMDocument");
    xmlDoc.async = false;
    xmlDoc.load(objectXmlDoc);
    
    
    //Create XSLT processor using stylesheet for XSL template.
    xslProc = xslt.createProcessor();
    xslProc.addParameter("js_param1", param1);
    xslProc.addParameter("js_param2", param2);
    xslProc.addParameter("js_param3", param3);

    //Assign XML file as input of the transform() method.
    xslProc.input = xmlDoc;

    //Do transformation on the XML file.
    xslProc.transform();
    var sResult = xslProc.output;       
    return sResult;
}

/*
***********************************************************************
* getResultNetscape_Paging function
* Takes three parameters 
    objectXslDoc    : Input XSL file
    objectXmlDoc    : Input XML file
    js_param        : Input paremeter based on which the search will be filter
    param1          : Javascript Parameter for XSL
    param2          : Javascript Parameter for XSL
    param3          : Javascript Parameter for XSL

*   - xmlDoc  : Instance of XML document
    - xslProc : Resulted processed XSL
    - sResult : Result after processing appropriate XML/XML and required 
    parameter as required for IE or Netscape
* This returns a translated documenent which can be directly 
  assigned to innerHTML area of the specified DIV
************************************************************************
*/

function getResultNetscape_Paging(objectXslDoc,objectXmlDoc,param1,param2,param3)
{
    var xslStylesheet;
    var xmlDoc;

    //Create XSLT processor using stylesheet for XSL template.
    var xsltProcessor = new XSLTProcessor();

    // load the xslt file
    var myXMLHTTPRequest = new XMLHttpRequest();
    myXMLHTTPRequest.open("GET", objectXslDoc, false);
    myXMLHTTPRequest.send(null);
    xslStylesheet = myXMLHTTPRequest.responseXML;
    xsltProcessor.importStylesheet(xslStylesheet);

    // set the paraneters to xslt file
    xsltProcessor.setParameter(null, "js_param1", param1);
    xsltProcessor.setParameter(null, "js_param2", param2);
    xsltProcessor.setParameter(null, "js_param3", param3);

    // load the xml file
    myXMLHTTPRequest = new XMLHttpRequest();
    myXMLHTTPRequest.open("GET", objectXmlDoc, false);
    myXMLHTTPRequest.send(null);
    objectXmlDoc = myXMLHTTPRequest.responseXML;

    // Prepare a transformed content to be loaded as HTML
    var fragment = xsltProcessor.transformToFragment(objectXmlDoc, document);

    // Return the conntent to the called function 
    return fragment;
}


/*
** Definition Status Summary: Add
*/
function defStatusSummary(objtype)
{
    if (_SARISSA_IS_IE || _SARISSA_IS_IE9 || _IS_IE11)
    {
        // transform and store the results to a string
        var sResult = getResultIE('defStatus.xsl','project.xml',objtype);       
        document.getElementById("divDefStatusSummary").innerHTML = sResult;
    }else{

        // transform and store the results to a DOM
        var sResult = getResultNetscape("defStatus.xsl","project.xml",objtype);
        document.getElementById("divDefStatusSummary").appendChild(sResult);
    }
}
