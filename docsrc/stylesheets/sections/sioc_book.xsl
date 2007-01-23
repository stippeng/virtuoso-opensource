<?xml version='1.0'?>
<!--
 -  
 -  $Id$
 -
 -  This file is part of the OpenLink Software Virtuoso Open-Source (VOS)
 -  project.
 -  
 -  Copyright (C) 1998-2006 OpenLink Software
 -  
 -  This project is free software; you can redistribute it and/or modify it
 -  under the terms of the GNU General Public License as published by the
 -  Free Software Foundation; only version 2 of the License, dated June 1991.
 -  
 -  This program is distributed in the hope that it will be useful, but
 -  WITHOUT ANY WARRANTY; without even the implied warranty of
 -  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 -  General Public License for more details.
 -  
 -  You should have received a copy of the GNU General Public License along
 -  with this program; if not, write to the Free Software Foundation, Inc.,
 -  51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
 -  
 -  
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:content="http://purl.org/rss/1.0/modules/content/"
  xmlns:sioc="http://rdfs.org/sioc/ns#"
                version='1.0'>
<xsl:output method="xml" indent="yes" />

<!-- ==================================================================== -->

	<xsl:param name="imgroot">../images/</xsl:param>
	<xsl:param name="chap">overview</xsl:param>
	<xsl:param name="serveraddr">http://localhost:8890/doc/html</xsl:param>
	<xsl:param name="thedate">not specified</xsl:param>

<!-- ==================================================================== -->

<xsl:template match="/">
  <rdf:RDF xmlns="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
    <xsl:apply-templates select="/book"/>
  </rdf:RDF>
</xsl:template>

<xsl:template match="/book">
  <sioc:Site>
    <xsl:attribute name="rdf:about"><xsl:value-of select="$serveraddr"/></xsl:attribute>
    <sioc:name><xsl:value-of select="title"/></sioc:name>
    <sioc:description><xsl:value-of select="title"/></sioc:description>
          
    <xsl:for-each select="chapter">
      <sioc:host_of>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$serveraddr"/>/<xsl:value-of select="@id" />.html</xsl:attribute>
      </sioc:host_of>
    </xsl:for-each>
  </sioc:Site>

  <xsl:apply-templates select="chapter" />
  
</xsl:template>

<xsl:template match="chapter" priority="10">
  <sioc:Forum>
    <xsl:attribute name="rdf:about"><xsl:value-of select="$serveraddr"/>/<xsl:value-of select="@id" />.html</xsl:attribute>
    <sioc:name><xsl:value-of select="title"/></sioc:name>
    <sioc:has_host>
      <xsl:attribute name="rdf:resource"><xsl:value-of select="$serveraddr"/></xsl:attribute>
    </sioc:has_host>
<!--    <rdfs:seeAlso>
      <xsl:attribute name="rdf:resource"><xsl:value-of select="$serveraddr"/>/<xsl:value-of select="@id" />.sioc.rdf</xsl:attribute>
    </rdfs:seeAlso>-->
    <xsl:for-each select="sect1">
      <sioc:container_of>
        <xsl:attribute name="rdf:resource"><xsl:value-of select="$serveraddr"/>/<xsl:value-of select="@id" />.html</xsl:attribute>
      </sioc:container_of>
    </xsl:for-each>
    <sioc:type>Documentation</sioc:type>
  </sioc:Forum>


  <xsl:apply-templates select="sect1" />

</xsl:template>

<xsl:template match="sect1" priority="10">
  <sioc:Post>
    <xsl:attribute name="rdf:about"><xsl:value-of select="$serveraddr"/>/<xsl:value-of select="@id" />.html</xsl:attribute>
    <sioc:has_container>
      <xsl:attribute name="rdf:resource"><xsl:value-of select="$serveraddr"/>/<xsl:value-of select="parent::chapter/@id" />.html</xsl:attribute>
    </sioc:has_container>
    <sioc:title><xsl:value-of select="title"/></sioc:title>
    <rdfs:seeAlso>
      <xsl:attribute name="rdf:resource"><xsl:value-of select="$serveraddr"/>/<xsl:value-of select="@id" />.sioc.rdf</xsl:attribute>
    </rdfs:seeAlso>
  </sioc:Post>
</xsl:template>

</xsl:stylesheet>
