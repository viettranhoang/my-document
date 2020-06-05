<?xml version="1.0"?>
<recipe>

    <instantiate from="root/src/app_package/Adapter.kt.ftl"
                   to="${escapeXmlAttribute(srcOut)}/${adapterClass}.kt" />

    <instantiate from="root/res/layout/item.xml.ftl"
                 to="${escapeXmlAttribute(resOut)}/layout/${layoutItem}.xml" />

	<open file="${escapeXmlAttribute(resOut)}/layout/${layoutItem}.xml" />
	<open file="${escapeXmlAttribute(srcOut)}/${adapterClass}.java" />
</recipe>
