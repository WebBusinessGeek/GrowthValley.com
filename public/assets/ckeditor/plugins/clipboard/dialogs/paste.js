/*
 Copyright (c) 2003-2014, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.md or http://ckeditor.com/license
*/
CKEDITOR.dialog.add("paste",function(e){function t(t){var n=new CKEDITOR.dom.document(t.document),i=n.getBody(),a=n.getById("cke_actscrpt");a&&a.remove(),i.setAttribute("contenteditable",!0),CKEDITOR.env.ie&&8>CKEDITOR.env.version&&n.getWindow().on("blur",function(){n.$.selection.empty()}),n.on("keydown",function(e){var t,e=e.data;switch(e.getKeystroke()){case 27:this.hide(),t=1;break;case 9:case CKEDITOR.SHIFT+9:this.changeFocus(1),t=1}t&&e.preventDefault()},this),e.fire("ariaWidget",new CKEDITOR.dom.element(t.frameElement)),n.getWindow().getFrame().removeCustomData("pendingFocus")&&i.focus()}var n=e.lang.clipboard;return e.on("pasteDialogCommit",function(t){t.data&&e.fire("paste",{type:"auto",dataValue:t.data})},null,null,1e3),{title:n.title,minWidth:CKEDITOR.env.ie&&CKEDITOR.env.quirks?370:350,minHeight:CKEDITOR.env.quirks?250:245,onShow:function(){this.parts.dialog.$.offsetHeight,this.setupContent(),this.parts.title.setHtml(this.customTitle||n.title),this.customTitle=null},onLoad:function(){(CKEDITOR.env.ie7Compat||CKEDITOR.env.ie6Compat)&&"rtl"==e.lang.dir&&this.parts.contents.setStyle("overflow","hidden")},onOk:function(){this.commitContent()},contents:[{id:"general",label:e.lang.common.generalTab,elements:[{type:"html",id:"securityMsg",html:'<div style="white-space:normal;width:340px">'+n.securityMsg+"</div>"},{type:"html",id:"pasteMsg",html:'<div style="white-space:normal;width:340px">'+n.pasteMsg+"</div>"},{type:"html",id:"editing_area",style:"width:100%;height:100%",html:"",focus:function(){var e=this.getInputElement(),t=e.getFrameDocument().getBody();!t||t.isReadOnly()?e.setCustomData("pendingFocus",1):t.focus()},setup:function(){var i=this.getDialog(),a='<html dir="'+e.config.contentsLangDirection+'" lang="'+(e.config.contentsLanguage||e.langCode)+'"><head><style>body{margin:3px;height:95%}</style></head><body><script id="cke_actscrpt" type="text/javascript">window.parent.CKEDITOR.tools.callFunction('+CKEDITOR.tools.addFunction(t,i)+",this);</script></body></html>",o=CKEDITOR.env.air?"javascript:void(0)":CKEDITOR.env.ie?"javascript:void((function(){"+encodeURIComponent("document.open();("+CKEDITOR.tools.fixDomain+")();document.close();")+'})())"':"",r=CKEDITOR.dom.element.createFromHtml('<iframe class="cke_pasteframe" frameborder="0"  allowTransparency="true" src="'+o+'" role="region" aria-label="'+n.pasteArea+'" aria-describedby="'+i.getContentElement("general","pasteMsg").domId+'" aria-multiple="true"></iframe>');if(r.on("load",function(n){n.removeListener(),n=r.getFrameDocument(),n.write(a),e.focusManager.add(n.getBody()),CKEDITOR.env.air&&t.call(this,n.getWindow().$)},i),r.setCustomData("dialog",i),i=this.getElement(),i.setHtml(""),i.append(r),CKEDITOR.env.ie){var l=CKEDITOR.dom.element.createFromHtml('<span tabindex="-1" style="position:absolute" role="presentation"></span>');l.on("focus",function(){setTimeout(function(){r.$.contentWindow.focus()})}),i.append(l),this.focus=function(){l.focus(),this.fire("focus")}}this.getInputElement=function(){return r},CKEDITOR.env.ie&&(i.setStyle("display","block"),i.setStyle("height",r.$.offsetHeight+2+"px"))},commit:function(){var e,t=this.getDialog().getParentEditor(),n=this.getInputElement().getFrameDocument().getBody(),i=n.getBogus();i&&i.remove(),e=n.getHtml(),setTimeout(function(){t.fire("pasteDialogCommit",e)},0)}}]}]}});