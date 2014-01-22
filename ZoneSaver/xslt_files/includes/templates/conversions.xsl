<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!-- Rounds and formats a percentage. -->
	<xsl:template name="format_percent">
		<xsl:param name="value" />
		<xsl:param name="of" />
    <xsl:if test=" number($value)">
		<xsl:choose>
			 <xsl:when test="$of > 0">
				<xsl:value-of select=" round( ($value div $of) * 100 ) " />&#160;%
			 </xsl:when>
			 <xsl:otherwise>
			 	0&#160;%
			 </xsl:otherwise>
		</xsl:choose>
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
	</xsl:template>

  <xsl:template name="convert_ratio_to_percent">
    <xsl:param name="value" />
    <xsl:if test=" number($value)">
      <xsl:value-of select=" format-number( ($value * 100 ),'#,##0.0') " />
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
  </xsl:template>
  
  <xsl:template name="format_ratio">
    <xsl:param name="value" />
    <xsl:if test=" number($value)">
      <xsl:value-of select=" format-number( ($value ),'#,##0.0') " />
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
  </xsl:template>
  
	<!-- 
	==============================================================
		Celcius to Farenheit
		
		f = ( 9 / 5 ) * ( c + 32 )
		
	==============================================================
	-->
	<xsl:template name="tempFormat">
		<xsl:param name="value" />
    <xsl:if test="number($value)">
		<xsl:choose>
			<xsl:when test="$units = 'imp'">
				<xsl:value-of select=" format-number(( 9 div 5) * ( $value + 32 ),'##0.0')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($value,'##0.0')" />
			</xsl:otherwise>
		</xsl:choose>
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
	</xsl:template>
	
	<xsl:template name="tempSuffix">
		<xsl:choose>
			<xsl:when test="$units = 'imp'">
				(<xsl:value-of select="$tplLang/units/temp/imp[@xml:lang=$lang]" />)
			</xsl:when>
			<xsl:otherwise>
				(<xsl:value-of select="$tplLang/units/temp/si[@xml:lang=$lang]" />)
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

  <xsl:template name="tempSuffixNoBrackets">
    <xsl:choose>
      <xsl:when test="$units = 'imp'">
        <xsl:text>&#32;</xsl:text><xsl:value-of select="$tplLang/units/temp/imp[@xml:lang=$lang]" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>&#32;</xsl:text><xsl:value-of select="$tplLang/units/temp/si[@xml:lang=$lang]" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
	<!-- 
	==============================================================
		Mega Joules to Millions of BTU's 
		
		Mil.BTU = MJ * 947.817

    Both imperial and si units are multiplied by 1000 to convert
    the xml source data from MJ to GJ.
		
	==============================================================
	-->

  <xsl:template name="heatValue">
    <xsl:param name="value" />
    <xsl:if test="number($value)">
      <xsl:choose>
        <xsl:when test="$units = 'imp'">
          <xsl:value-of select="$value * 947.817 " />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$value " />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
  </xsl:template>

  
	<xsl:template name="heatFormat">
		<xsl:param name="value" />
    <xsl:if test="number($value)">
      <xsl:choose>
        <xsl:when test="$units = 'imp'">
          <xsl:value-of select="format-number($value * 947.817 * 1000.,'###,###,###')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="format-number($value * 1000.,'###,###,###') " />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
	</xsl:template>


  <xsl:template name="heatSum">
    <xsl:param name="value1" />
    <xsl:param name="value2" />
    <xsl:param name="value3" />
    <xsl:param name="value4" />
    <xsl:if test="number($value1+$value2+$value3+$value4)">
      <xsl:choose>
        <xsl:when test="$units = 'imp'">
          <xsl:value-of select="format-number(($value1+$value2+$value3+$value4) * 947.817 * 1000.,'###,###,###')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="format-number(($value1+$value2+$value3+$value4) * 1000.,'###,###,###') " />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="not( number($value1+$value2+$value3+$value4))">&#x2013;</xsl:if>
  </xsl:template>
	
	<xsl:template name="heatSuffix">
		<xsl:choose>
			<xsl:when test="$units = 'imp'">
				(<xsl:value-of select="$tplLang/units/heat/imp[@xml:lang=$lang]" />)
			</xsl:when>
			<xsl:otherwise>
				(<xsl:value-of select="$tplLang/units/heat/si[@xml:lang=$lang]" />)
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


  <xsl:template name="heatSuffixNoBrackets">
    <xsl:choose>
      <xsl:when test="$units = 'imp'">
        <xsl:text>&#32;</xsl:text><xsl:value-of select="$tplLang/units/heat/imp[@xml:lang=$lang]" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>&#32;</xsl:text><xsl:value-of select="$tplLang/units/heat/si[@xml:lang=$lang]" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
	
	<!-- 
	==============================================================
		Litres to Gallons
		
		G = L * 0.2641720
	==============================================================
	-->
	<xsl:template name="liquidVolumeFormat">
		<xsl:param name="value" />
    <xsl:if test="number($value)">
      <xsl:choose>
        <xsl:when test="$units = 'imp'">
          <xsl:value-of select="format-number($value * 0.2641720,'###,###,###')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="format-number($value,'###,###,###')" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
	</xsl:template>
	
	<xsl:template name="liquidVolumeSuffix">
		<xsl:choose>
			<xsl:when test="$units = 'imp'">
				(<xsl:value-of select="$tplLang/units/volume/liquid/imp[@xml:lang=$lang]" />)
			</xsl:when>
			<xsl:otherwise>
				(<xsl:value-of select="$tplLang/units/volume/liquid/si[@xml:lang=$lang]" />)
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

  <xsl:template name="liquidVolumeSuffixNoBrackets">
    <xsl:choose>
      <xsl:when test="$units = 'imp'">
        <xsl:text>&#32;</xsl:text><xsl:value-of select="$tplLang/units/volume/liquid/imp[@xml:lang=$lang]" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:text>&#32;</xsl:text><xsl:value-of select="$tplLang/units/volume/liquid/si[@xml:lang=$lang]" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
	<!-- 
	==============================================================
		Cubic Metres to Cubic Feet
		
		ft3 = m3 * 35.314666
	==============================================================
	-->
	<xsl:template name="cubicSizeFormat">
		<xsl:param name="value" />
    <xsl:if test=" number($value)">
      <xsl:choose>
        <xsl:when test="$units = 'imp'">
          <xsl:value-of select="format-number($value * 35.314666,'###,###,##0.0')" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="format-number($value,'###,###,##0.0')" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
	</xsl:template>
	
	<xsl:template name="cubicSizeSuffix">
		<xsl:choose>
			<xsl:when test="$units = 'imp'">
				(<xsl:value-of select="$tplLang/units/volume/size/imp[@xml:lang=$lang]" />)
			</xsl:when>
			<xsl:otherwise>
				(<xsl:value-of select="$tplLang/units/volume/size/si[@xml:lang=$lang]" />)
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	
	<!-- 
	==============================================================
		Tonne to Cord
		
		C = T * 0.5815
	==============================================================
	-->
	<xsl:template name="massFormat">
		<xsl:param name="value" />
    <xsl:if test=" number($value)">
		<xsl:choose>
			<xsl:when test="$units = 'imp'">
				<xsl:value-of select="format-number($value * 0.5815,'###,###,##0.0')" />
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="format-number($value,'###,###,##0.0')" />
			</xsl:otherwise>
		</xsl:choose>
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
	</xsl:template>
	
	<xsl:template name="massSuffix">
		<xsl:choose>
			<xsl:when test="$units = 'imp'">
				(<xsl:value-of select="$tplLang/units/mass/imp[@xml:lang=$lang]" />)
			</xsl:when>
			<xsl:otherwise>
				(<xsl:value-of select="$tplLang/units/mass/si[@xml:lang=$lang]" />)
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

  <!--
  ==============================================================
    kWh
  ==============================================================
  -->

  <xsl:template name="kWhFormat">
    <xsl:param name="value" />
    <xsl:if test=" number($value)">
    <xsl:choose>
      <xsl:when test="$units = 'imp'">
        <xsl:value-of select="format-number($value,'###,###,##0')" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="format-number($value,'###,###,##0')" />
      </xsl:otherwise>
    </xsl:choose>
    </xsl:if>
    <xsl:if test="not( number($value))">&#x2013;</xsl:if>
  </xsl:template>


	<xsl:template name="kwhSuffix">
		(<xsl:value-of select="$tplLang/units/kwh[@xml:lang=$lang]" />)
	</xsl:template>

	<xsl:template name="wattsSuffix">
		(<xsl:value-of select="$tplLang/units/watts[@xml:lang=$lang]" />)
	</xsl:template>
	
	
	
	
</xsl:stylesheet>