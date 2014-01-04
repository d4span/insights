<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template match="/">
		<menu_structure>
			<xsl:apply-templates/>
		</menu_structure>
	</xsl:template>
	
	<xsl:template match="menu_category">
		<menu_category name="menu_bar">
			<menu_submenu name="file" name_ref="file">	
				<xsl:apply-templates select="ribbon_taskbar"/>
				<xsl:apply-templates select="ribbon_menu/primary_entry"/>
				<xsl:apply-templates select="ribbon_menu/footer_entry"/>
			</menu_submenu>
			<xsl:apply-templates select="ribbon_task"/>
		</menu_category>
	</xsl:template>
	
	<xsl:template match="ribbon_taskbar">
		<xsl:apply-templates/>
	</xsl:template>
	
	<xsl:template match="separator">
		<menu_separator/>
	</xsl:template>
	
	<xsl:template match="ribbon_task">
		<xsl:element name="menu_submenu">
			<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
			<xsl:attribute name="name_ref"><xsl:value-of select="@name"/></xsl:attribute>
			<xsl:apply-templates/>
		</xsl:element>	
	</xsl:template>
	
	<xsl:template match="primary_entry|footer_entry|entry_group|ribbon_action|ribbon_band">
		<xsl:choose>
			<xsl:when test="@name and *">
				<xsl:element name="menu_submenu">
					<xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
					<xsl:attribute name="name_ref"><xsl:value-of select="@name"/></xsl:attribute>
					<xsl:call-template name="action"></xsl:call-template>
					<xsl:apply-templates/>
				</xsl:element>	
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="action"></xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="accelerator">
		<xsl:if test="@accelerator">
			<xsl:variable name="accelerator" select="@accelerator"/>
			<xsl:if test="not(preceding::*[@accelerator = $accelerator])">
				<xsl:attribute name="accelerator"><xsl:value-of select="@accelerator"/></xsl:attribute>
			</xsl:if>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="action">
		<xsl:if test="@action">
			<xsl:variable name="action" select="@action"/>
			<xsl:element name="menu_action">
				<xsl:attribute name="action"><xsl:value-of select="@action"/></xsl:attribute>
				<xsl:call-template name="accelerator"></xsl:call-template>
			</xsl:element>	
		</xsl:if>
	</xsl:template> 							
</xsl:stylesheet>