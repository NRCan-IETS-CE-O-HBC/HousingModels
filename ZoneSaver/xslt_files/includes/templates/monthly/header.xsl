<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<xsl:template name="header">
		
			<head>
				<title><xsl:value-of select="$tplLang/language/monthly/title" /></title>
				
				<link href="h3k_stylesheet.css" rel="stylesheet" type="text/css" />
			</head>
	
	</xsl:template>
	
</xsl:stylesheet>