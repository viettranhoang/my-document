<?xml version="1.0"?>
<recipe>

    <instantiate from="root/src/app_package/Fragment.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${fragmentClass}Fragment.kt" />
				   
	<instantiate from="root/src/app_package/viewmodel/ViewModel.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/viewmodel/${fragmentClass}ViewModel.kt" />

	<instantiate from="root/src/app_package/di/Component.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/di/${fragmentClass}Component.kt" />				   

	<instantiate from="root/src/app_package/di/Module.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/di/${fragmentClass}Module.kt" />
				   
    <instantiate from="root/res/layout/layout.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${layout}.xml" />

	<open file="${escapeXmlAttribute(resOut)}/layout/${layout}.xml" />
	<open file="${escapeXmlAttribute(srcOut)}/${fragmentClass}.java" />
</recipe>
