<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	
	<xsl:variable name="BPTemplate" select="$tplLang/h3k/templates/template[ @name = 'building_parameters' ]"  />
	
	<xsl:template match="*" mode="building_parameters">

    <!-- Site TOTAL -->
    <xsl:variable name="siteTotal">
      <xsl:call-template name="heatValue">
        <xsl:with-param name="value" select="/system/building/all_zones/envelope/all_components/heat_loss/integrated_data/bin[@type='annual']" />
      </xsl:call-template>
    </xsl:variable>

		<h1><xsl:value-of select="$BPTemplate/title[@xml:lang=$lang]" /></h1>
    <p><xsl:value-of select="$BPTemplate/description[@xml:lang=$lang]" /></p>

    <table cellspacing="0">
      <colgroup span="4">
        <col align="left"></col>
        <col align="left"></col>
        <col align="right"></col>
<!--        <col align="right"></col>-->
      </colgroup>


      <tr class="headerRow">
        <th>
          <xsl:value-of select="$tplLang/zone[@xml:lang=$lang]" />
        </th>
        <th>
          <xsl:value-of select="$BPTemplate/headings/component[@xml:lang=$lang]" />
        </th>
<!--    NOTE: Quantitative description of heat loss is disabled pending 
              further investigation into ESP-r common block variable definitions -->
<!--        <th align="right">
          <xsl:value-of select="$BPTemplate/headings/heat_loss[@xml:lang=$lang]" />
          <xsl:call-template name="heatSuffix" />
        </th>-->
        <th align="right">
          <xsl:value-of select="$BPTemplate/headings/percent_annual_heat_loss[@xml:lang=$lang]" />
        </th>
      </tr>

      <xsl:apply-templates select="/system/building/*[ contains( local-name( ), 'zone_' ) ]" mode="bp_data">
        <xsl:with-param name="siteTotal" select="$siteTotal" />
      </xsl:apply-templates>

      <tr class="totalRow">
        <th>
          <xsl:value-of select="$tplLang/all_zones[@xml:lang=$lang]" />
        </th>
        <th>
          <xsl:value-of select="$BPTemplate/headings/total[@xml:lang=$lang]" />
        </th>
<!--        <th align="right">
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="$siteTotal" />
          </xsl:call-template>
        </th>-->
        <th align="right">
          <xsl:call-template name="format_percent">
            <xsl:with-param name="value" select="$siteTotal" />
            <xsl:with-param name="of" select="$siteTotal" />
          </xsl:call-template>
        </th>
      </tr>
    </table>

    <br />
  
	</xsl:template>
	
	
	<!-- 
	=============================================================================
	
	Template Name: ac
	Data Created: MAR.05.2008
    
	Description:
		
		Main template for the A/C Report.
	
	=============================================================================
	-->
	<xsl:template match="*" mode="bp_data">
	
	        <xsl:param name="siteTotal" />
	
		<xsl:param name="zoneNumber" select=" substring-after( local-name( ) , '_' ) " />
		<xsl:param name="zoneLabel" select=" concat( $tplLang/zone[@xml:lang=$lang], ' ', $zoneNumber ) " />

		<!-- WALLS -->
		<xsl:variable name="walls">
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="envelope/walls/heat_loss/integrated_data/bin[@type='annual']"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- CEILINGS -->
		<xsl:variable name="ceilings">
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="envelope/ceilings/heat_loss/integrated_data/bin[@type='annual']"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- FLOORS -->
		<xsl:variable name="floors">
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="envelope/floors/heat_loss/integrated_data/bin[@type='annual']"/>
			</xsl:call-template>
		</xsl:variable>

		<!-- WINDOWS -->
		<xsl:variable name="windows">
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="envelope/windows/heat_loss/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>

		<!-- FOUNDATION -->
		<xsl:variable name="foundation">
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="envelope/foundation/heat_loss/integrated_data/bin[@type='annual']" />
			</xsl:call-template>
		</xsl:variable>

    <!-- INFILTRATION -->
    <xsl:variable name="infiltration">
      <xsl:call-template name="heatValue">
        <xsl:with-param name="value" select="envelope/infiltration/heat_loss/integrated_data/bin[@type='annual']" />
      </xsl:call-template>
    </xsl:variable>

		<!-- Zone TOTAL -->
		<xsl:variable name="compTotal">
			<xsl:call-template name="heatValue">
				<xsl:with-param name="value" select="envelope/all_components/heat_loss/integrated_data/bin[@type='annual']"/>
			</xsl:call-template>
		</xsl:variable>


			
			<!-- WALLS -->
			<tr class="row">
        <th> <xsl:value-of select="$zoneLabel" /> </th>
				<th> <xsl:value-of select="$BPTemplate/headings/walls[@xml:lang=$lang]" />	</th>
<!--				<td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="$walls" />
          </xsl:call-template>
        </td>-->
				<td> 
					<xsl:call-template name="format_percent">
						<xsl:with-param name="value" select="$walls" />
						<xsl:with-param name="of" select="$siteTotal" />
					</xsl:call-template>
				</td>
			</tr>
			
			<!-- CEILINGS -->
			<tr class="altRow">
        <th> </th>
				<th><xsl:value-of select="$BPTemplate/headings/ceiling[@xml:lang=$lang]" /></th>
<!--        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="$ceilings" />
          </xsl:call-template>
        </td>-->
				<td> 
					<xsl:call-template name="format_percent">
						<xsl:with-param name="value" select="$ceilings" />
						<xsl:with-param name="of" select="$siteTotal" />
					</xsl:call-template>
				</td>
			</tr>
			
			<!-- FLOORS -->
			<tr class="row">
        <th> </th>
				<th><xsl:value-of select="$BPTemplate/headings/overhanging_floors[@xml:lang=$lang]" /></th>
<!--        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="$floors" />
          </xsl:call-template>
        </td>-->
				<td> 
					<xsl:call-template name="format_percent">
						<xsl:with-param name="value" select="$floors" />
						<xsl:with-param name="of" select="$siteTotal" />
					</xsl:call-template>
				</td>
			</tr>
			
			<!-- WINDOWS -->
			<tr class="altRow">
        <th> </th>
				<th><xsl:value-of select="$BPTemplate/headings/windows[@xml:lang=$lang]" /></th>
<!--        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="$windows" />
          </xsl:call-template>
        </td>-->
				<td> 
					<xsl:call-template name="format_percent">
						<xsl:with-param name="value" select="$windows" />
						<xsl:with-param name="of" select="$siteTotal" />
					</xsl:call-template>
				</td>
			</tr>
			
			<!-- FOUNDATIONS -->
			<tr class="row">
        <th> </th>
				<th><xsl:value-of select="$BPTemplate/headings/foundations[@xml:lang=$lang]" /></th>
<!--        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="$foundation" />
          </xsl:call-template>
        </td>-->
        <td>
					<xsl:call-template name="format_percent">
						<xsl:with-param name="value" select="$foundation" />
						<xsl:with-param name="of" select="$siteTotal" />
					</xsl:call-template>
				</td>
			</tr>

      <!-- INFILTRATION -->
      <tr class="altRow">
        <th> </th>
        <th><xsl:value-of select="$BPTemplate/headings/infiltration[@xml:lang=$lang]" /></th>
<!--        <td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="$infiltration" />
          </xsl:call-template>
        </td>-->
        <td>
          <xsl:call-template name="format_percent">
            <xsl:with-param name="value" select="$infiltration" />
            <xsl:with-param name="of" select="$siteTotal" />
          </xsl:call-template>
        </td>
      </tr>

			<!-- SUBTOTAL -->
			<tr class="subtotalRow">
        <th> </th>
				<th><xsl:value-of select="$zoneLabel" />&#160;<xsl:value-of select="$BPTemplate/headings/subtotal[@xml:lang=$lang]" /></th>
<!--				<td>
          <xsl:call-template name="heatFormat">
            <xsl:with-param name="value" select="$compTotal" />
          </xsl:call-template>
        </td>-->
				<td> 
					<xsl:call-template name="format_percent">
						<xsl:with-param name="value" select="$compTotal" />
						<xsl:with-param name="of" select="$siteTotal" />
					</xsl:call-template>
				</td>
			</tr>

			
<!--			 Infiltration
			<tr>
        <th> </th>
				<th> <xsl:value-of select="$BPTemplate/headings/infltration_ACH[@xml:lang=$lang]" /> </th>
				<td> <xsl:value-of select="envelope/infiltration/air_changes_per_hour/binned_data[@type='annual']/active_average" /> </td>
				<td>  </td>
			</tr>-->
		
		
	</xsl:template>
	
	
</xsl:stylesheet>