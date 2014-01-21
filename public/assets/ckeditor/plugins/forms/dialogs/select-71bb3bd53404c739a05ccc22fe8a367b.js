/*
 Copyright (c) 2003-2013, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
CKEDITOR.dialog.add("select",function(e){function t(e,t,i,n,o){return e=c(e),n=n?n.createElement("OPTION"):document.createElement("OPTION"),e&&n&&"option"==n.getName()?(CKEDITOR.env.ie?(isNaN(parseInt(o,10))?e.$.options.add(n.$):e.$.options.add(n.$,o),n.$.innerHTML=0<t.length?t:"",n.$.value=i):(null!==o&&o<e.getChildCount()?e.getChild(0>o?0:o).insertBeforeMe(n):e.append(n),n.setText(0<t.length?t:""),n.setValue(i)),n):!1}function i(e){for(var e=c(e),t=r(e),i=e.getChildren().count()-1;i>=0;i--)e.getChild(i).$.selected&&e.getChild(i).remove();s(e,t)}function n(e,t,i,n){return e=c(e),0>t?!1:(e=e.getChild(t),e.setText(i),e.setValue(n),e)}function o(e){for(e=c(e);e.getChild(0)&&e.getChild(0).remove(););}function a(e,i,n){var e=c(e),o=r(e);if(0>o)return!1;if(i=o+i,i=0>i?0:i,i=i>=e.getChildCount()?e.getChildCount()-1:i,o==i)return!1;var o=e.getChild(o),a=o.getText(),l=o.getValue();return o.remove(),o=t(e,a,l,n?n:null,i),s(e,i),o}function r(e){return(e=c(e))?e.$.selectedIndex:-1}function s(e,t){if(e=c(e),0>t)return null;var i=e.getChildren().count();return e.$.selectedIndex=t>=i?i-1:t,e}function l(e){return(e=c(e))?e.getChildren():!1}function c(e){return e&&e.domId&&e.getInputElement().$?e.getInputElement():e&&e.$?e:!1}return{title:e.lang.forms.select.title,minWidth:CKEDITOR.env.ie?460:395,minHeight:CKEDITOR.env.ie?320:300,onShow:function(){delete this.selectBox,this.setupContent("clear");var e=this.getParentEditor().getSelection().getSelectedElement();if(e&&"select"==e.getName()){this.selectBox=e,this.setupContent(e.getName(),e);for(var e=l(e),t=0;t<e.count();t++)this.setupContent("option",e.getItem(t))}},onOk:function(){var e=this.getParentEditor(),t=this.selectBox,i=!t;if(i&&(t=e.document.createElement("select")),this.commitContent(t),i&&(e.insertElement(t),CKEDITOR.env.ie)){var n=e.getSelection(),o=n.createBookmarks();setTimeout(function(){n.selectBookmarks(o)},0)}},contents:[{id:"info",label:e.lang.forms.select.selectInfo,title:e.lang.forms.select.selectInfo,accessKey:"",elements:[{id:"txtName",type:"text",widths:["25%","75%"],labelLayout:"horizontal",label:e.lang.common.name,"default":"",accessKey:"N",style:"width:350px",setup:function(e,t){"clear"==e?this.setValue(this["default"]||""):"select"==e&&this.setValue(t.data("cke-saved-name")||t.getAttribute("name")||"")},commit:function(e){this.getValue()?e.data("cke-saved-name",this.getValue()):(e.data("cke-saved-name",!1),e.removeAttribute("name"))}},{id:"txtValue",type:"text",widths:["25%","75%"],labelLayout:"horizontal",label:e.lang.forms.select.value,style:"width:350px","default":"",className:"cke_disabled",onLoad:function(){this.getInputElement().setAttribute("readOnly",!0)},setup:function(e,t){"clear"==e?this.setValue(""):"option"==e&&t.getAttribute("selected")&&this.setValue(t.$.value)}},{type:"hbox",widths:["175px","170px"],children:[{id:"txtSize",type:"text",labelLayout:"horizontal",label:e.lang.forms.select.size,"default":"",accessKey:"S",style:"width:175px",validate:function(){var t=CKEDITOR.dialog.validate.integer(e.lang.common.validateNumberFailed);return""===this.getValue()||t.apply(this)},setup:function(e,t){"select"==e&&this.setValue(t.getAttribute("size")||""),CKEDITOR.env.webkit&&this.getInputElement().setStyle("width","86px")},commit:function(e){this.getValue()?e.setAttribute("size",this.getValue()):e.removeAttribute("size")}},{type:"html",html:"<span>"+CKEDITOR.tools.htmlEncode(e.lang.forms.select.lines)+"</span>"}]},{type:"html",html:"<span>"+CKEDITOR.tools.htmlEncode(e.lang.forms.select.opAvail)+"</span>"},{type:"hbox",widths:["115px","115px","100px"],children:[{type:"vbox",children:[{id:"txtOptName",type:"text",label:e.lang.forms.select.opText,style:"width:115px",setup:function(e){"clear"==e&&this.setValue("")}},{type:"select",id:"cmbName",label:"",title:"",size:5,style:"width:115px;height:75px",items:[],onChange:function(){var e=this.getDialog(),t=e.getContentElement("info","cmbValue"),i=e.getContentElement("info","txtOptName"),e=e.getContentElement("info","txtOptValue"),n=r(this);s(t,n),i.setValue(this.getValue()),e.setValue(t.getValue())},setup:function(e,i){"clear"==e?o(this):"option"==e&&t(this,i.getText(),i.getText(),this.getDialog().getParentEditor().document)},commit:function(e){var i=this.getDialog(),n=l(this),a=l(i.getContentElement("info","cmbValue")),r=i.getContentElement("info","txtValue").getValue();o(e);for(var s=0;s<n.count();s++){var c=t(e,n.getItem(s).getValue(),a.getItem(s).getValue(),i.getParentEditor().document);a.getItem(s).getValue()==r&&(c.setAttribute("selected","selected"),c.selected=!0)}}}]},{type:"vbox",children:[{id:"txtOptValue",type:"text",label:e.lang.forms.select.opValue,style:"width:115px",setup:function(e){"clear"==e&&this.setValue("")}},{type:"select",id:"cmbValue",label:"",size:5,style:"width:115px;height:75px",items:[],onChange:function(){var e=this.getDialog(),t=e.getContentElement("info","cmbName"),i=e.getContentElement("info","txtOptName"),e=e.getContentElement("info","txtOptValue"),n=r(this);s(t,n),i.setValue(t.getValue()),e.setValue(this.getValue())},setup:function(e,i){if("clear"==e)o(this);else if("option"==e){var n=i.getValue();t(this,n,n,this.getDialog().getParentEditor().document),"selected"==i.getAttribute("selected")&&this.getDialog().getContentElement("info","txtValue").setValue(n)}}}]},{type:"vbox",padding:5,children:[{type:"button",id:"btnAdd",style:"",label:e.lang.forms.select.btnAdd,title:e.lang.forms.select.btnAdd,style:"width:100%;",onClick:function(){var e=this.getDialog();e.getParentEditor();var i=e.getContentElement("info","txtOptName"),n=e.getContentElement("info","txtOptValue"),o=e.getContentElement("info","cmbName"),a=e.getContentElement("info","cmbValue");t(o,i.getValue(),i.getValue(),e.getParentEditor().document),t(a,n.getValue(),n.getValue(),e.getParentEditor().document),i.setValue(""),n.setValue("")}},{type:"button",id:"btnModify",label:e.lang.forms.select.btnModify,title:e.lang.forms.select.btnModify,style:"width:100%;",onClick:function(){var e=this.getDialog(),t=e.getContentElement("info","txtOptName"),i=e.getContentElement("info","txtOptValue"),o=e.getContentElement("info","cmbName"),e=e.getContentElement("info","cmbValue"),a=r(o);a>=0&&(n(o,a,t.getValue(),t.getValue()),n(e,a,i.getValue(),i.getValue()))}},{type:"button",id:"btnUp",style:"width:100%;",label:e.lang.forms.select.btnUp,title:e.lang.forms.select.btnUp,onClick:function(){var e=this.getDialog(),t=e.getContentElement("info","cmbName"),i=e.getContentElement("info","cmbValue");a(t,-1,e.getParentEditor().document),a(i,-1,e.getParentEditor().document)}},{type:"button",id:"btnDown",style:"width:100%;",label:e.lang.forms.select.btnDown,title:e.lang.forms.select.btnDown,onClick:function(){var e=this.getDialog(),t=e.getContentElement("info","cmbName"),i=e.getContentElement("info","cmbValue");a(t,1,e.getParentEditor().document),a(i,1,e.getParentEditor().document)}}]}]},{type:"hbox",widths:["40%","20%","40%"],children:[{type:"button",id:"btnSetValue",label:e.lang.forms.select.btnSetValue,title:e.lang.forms.select.btnSetValue,onClick:function(){var e=this.getDialog(),t=e.getContentElement("info","cmbValue");e.getContentElement("info","txtValue").setValue(t.getValue())}},{type:"button",id:"btnDelete",label:e.lang.forms.select.btnDelete,title:e.lang.forms.select.btnDelete,onClick:function(){var e=this.getDialog(),t=e.getContentElement("info","cmbName"),n=e.getContentElement("info","cmbValue"),o=e.getContentElement("info","txtOptName"),e=e.getContentElement("info","txtOptValue");i(t),i(n),o.setValue(""),e.setValue("")}},{id:"chkMulti",type:"checkbox",label:e.lang.forms.select.chkMulti,"default":"",accessKey:"M",value:"checked",setup:function(e,t){"select"==e&&this.setValue(t.getAttribute("multiple")),CKEDITOR.env.webkit&&this.getElement().getParent().setStyle("vertical-align","middle")},commit:function(e){this.getValue()?e.setAttribute("multiple",this.getValue()):e.removeAttribute("multiple")}}]}]}]}});