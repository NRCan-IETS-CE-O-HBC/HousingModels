<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="LATemplate" select="$EECSection/templates/template[ @name = 'lights_appliances' ]"  />
	
	
	<!-- 
	=============================================================================
	
	Template Name: lights_appliances
	Data Created: MAR.07.2008
	
	Description:
		
		Main template for the Lights & Appliances Report.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="lights_appliances">
		<xsl:param name="xmlNode" select="." />

		<table border="0" cellspacing="0" cellpadding="0" class="monthly_report">
		
			<!-- Display all the headings using the language xml file. -->
			<tr class="title">
				<td colspan="5" align="center"><xsl:value-of select="$LATemplate/title[@xml:lang=$lang]" /></td>
			</tr>
			
			<tr class="headerRow">
				<td></td>
				<td align="center"></td>
				<th align="center"><xsl:value-of select="$LATemplate/headings/fans_pumps[@xml:lang=$lang]" /></th>
			</tr>
			
			<tr class="headerRow">
				<th><xsl:call-template name="month_table_header" /></th>

				<th>
					<xsl:value-of select="$LATemplate/headings/lights_appliances[@xml:lang=$lang]" />
					<xsl:call-template name="kwhSuffix" />
				</th>
				<th>
					<xsl:value-of select="$LATemplate/headings/hrv[@xml:lang=$lang]" />
					<xsl:call-template name="kwhSuffix" />
				</th>
			</tr>
			
			<!--  Loop through months and display output. -->
			<xsl:for-each select="$tplLang/months/month">
				<xsl:apply-templates select="$xmlNode" mode="lights_appliances_row">
					<xsl:with-param name="monthIndex" select="@id" />
				</xsl:apply-templates>
			</xsl:for-each>
		
		
			<!-- ANNUAL -->
			<xsl:apply-templates select="." mode="lights_appliances_annual_data" />
		
		</table>
		
		
		
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: lights_appliances_row
	Data Created: MAR.07.2008
	
	Description:
		
		This template allows the table to have alternate row colors. 
	
	=============================================================================
	-->
	<xsl:template match="*" mode="lights_appliances_row">
		<xsl:param name="monthIndex" />

		<xsl:choose>
			<xsl:when test="$monthIndex mod 2 = 0">
				<tr class="row">
					<xsl:apply-templates select="." mode="lights_appliances_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<tr class="altRow">
					<xsl:apply-templates select="." mode="lights_appliances_data">
						<xsl:with-param name="monthIndex" select="$monthIndex" />
					</xsl:apply-templates>
				</tr>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	
	
	
	<!-- 
	=============================================================================
	
	Template Name: lights_appliances_data
	Data Created: MAR.07.2008
	
	Description:
		
		Displays a row of monthly data for the Lights & Appliances Report - 
                including HRV
		
		TAGS USED:
			
					
	=============================================================================
	-->
	<xsl:template match="*" mode="lights_appliances_data">
		<xsl:param name="monthIndex" />
		
		<th>
			<xsl:call-template name="month_name">
				<xsl:with-param name="index" select="$monthIndex" />
			</xsl:call-template>
		</th>
		
		<td>
			<xsl:value-of select="'todo'" />
		</td>
		<td>
                        <xsl:call-template name="kWhFormat">
                           <xsl:with-param name="value"  select="plant/ideal_hvac_models/HRV/elec_load/integrated_data/bin[@type='monthly' and @number=$monthIndex]" />
                        </xsl:call-template>
		</td>
		
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: lights_appliances_annual_data
	Data Created: MAR.07.2008
	
	Description:
		
		Displays the Annual Lights & Appliances information.
		
	=============================================================================
	-->
	<xsl:template match="*" mode="lights_appliances_annual_data">
		<tr class="totalRow">
			<th><xsl:call-template name="annual_label" /></th>
			
			<td>
				<xsl:value-of select="'todo'" />
			</td>
			<td>
                            <xsl:call-template name="kWhFormat">
                               <xsl:with-param name="value"  select="plant/ideal_hvac_models/HRV/elec_load/integrated_data/bin[@type='annual']" />
                            </xsl:call-template>
			</td>
			
		</tr>
	</xsl:template>
	
</xsl:stylesheet>