<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="SHTemplate" select="$EECSection/templates/template[ @name = 'space_heating' ]"  />
	
	
	<!-- 
	=============================================================================
	
	Template Name: space_heating
	Data Created: MAR.05.2008
	
	Description:
		
		Main template for Space Heating Monthly Report.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="space_heating">
		<xsl:param name="xmlNode" select="." />
		
		<table border="0" cellpadding="0" cellspacing="0" class="monthly_report">
		
			<!-- Display all the headings using the language xml file. -->
			<tr class="title">
				<td colspan="5" align="center"><xsl:value-of select="$SHTemplate/title[@xml:lang=$lang]" /></td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2" align="center" class="title"><xsl:value-of select="$SHTemplate/headings/primary/label[@xml:lang=$lang]" /></td>
				<td colspan="2" align="center" class="title"><xsl:value-of select="$SHTemplate/headings/secondary/label[@xml:lang=$lang]" /></td>
			</tr>
			<tr class="headerRow">
				<th><xsl:call-template name="month_table_header" /></th>
				<th>
					<xsl:value-of select="$SHTemplate/headings/primary/fuel[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>
				<th>
					<xsl:value-of select="$SHTemplate/headings/primary/elec[@xml:lang=$lang]" />
					<xsl:call-template name="kwhSuffix" />
				</th>
				<th>
					<xsl:value-of select="$SHTemplate/headings/secondary/fuel[@xml:lang=$lang]" />
					<xsl:call-template name="heatSuffix" />
				</th>
				<th>
					<xsl:value-of select="$SHTemplate/headings/secondary/elec[@xml:lang=$lang]" />
					<xsl:call-template name="kwhSuffix" />
				</th>
			</tr>
			
			<!--  Loop through months and display output. -->
			<xsl:for-each select="$tplLang/months/month">
				<xsl:apply-templates select="$xmlNode" mode="space_heating_row">
					<xsl:with-param name="monthIndex" select="@id" />
				</xsl:apply-templates>
			</xsl:for-each>
		
		
			<!-- ANNUAL -->
			<xsl:apply-templates select="." mode="space_heating_annual_data" />
		
		</table>
		
		
		
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: space_heating_row
	Data Created: MAR.05.2008
	
	Description:
		
		This template allows the table to have alternate row colors. 
	
	=============================================================================
	-->
	<xsl:template match="*" mode="space_heating_row">
		<xsl:param name="monthIndex" />

		<xsl:choose>
			<xsl:when test="$monthIndex mod 2 = 0">
				<tr class="row">
					<xsl:apply-templates select="." mode="space_heating_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr class="altRow">
					<xsl:apply-templates select="." mode="space_heating_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: space_heating_data
	Data Created: MAR.05.2008
	
	Description:
		
		Displays a row of monthly data for the Space Heating Report.
		
		TAGS USED:
			
			== TODO ==
			
					
	=============================================================================
	-->
	<xsl:template match="*" mode="space_heating_data">
		<xsl:param name="monthIndex" />
		
		<th>
			<xsl:call-template name="month_name">
				<xsl:with-param name="index" select="$monthIndex" />
			</xsl:call-template>
		</th>
		
		<td>
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="'0'" />
			</xsl:call-template>
			todo
		</td>
		<td>
			<xsl:value-of select="'todo'" />
		</td>
		<td>
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="'0'" />
			</xsl:call-template>
			todo
		</td>
		<td>
			<xsl:value-of select="'todo'" />
		</td>
		
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: space_heating_annual_data
	Data Created: MAR.05.2008
	
	Description:
		
		Displays the Annual Space Heating information.
		
	=============================================================================
	-->
	<xsl:template match="*" mode="space_heating_annual_data">
		<tr class="totalRow">
			<th><xsl:call-template name="annual_label" /></th>
			<td>
				<xsl:call-template name="heatValue">
					<xsl:with-param name="value" select="'0'" />
				</xsl:call-template>
				todo
			</td>
			<td>
				<xsl:value-of select="'todo'" />
			</td>
			<td>
				<xsl:call-template name="heatValue">
					<xsl:with-param name="value" select="'0'" />
				</xsl:call-template>
				todo
			</td>
			<td>
				<xsl:value-of select="'todo'" />
			</td>
		</tr>
	</xsl:template>
	
</xsl:stylesheet>