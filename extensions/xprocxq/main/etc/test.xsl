<!-- Generates html version of Unit Test results //-->
<!-- TODO: uses XSLT 2.0 at the moment //-->
<xsl:stylesheet
 xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
 xmlns:fn='http://www.w3.org/2003/05/xpath-functions'
 version="2.0" >
     
<xsl:output indent="yes"/>

<xsl:variable name="total" select="count(testsuite/test)"/>
<xsl:variable name="success" select="count(testsuite/test[contains(result,expected)])"/>
<xsl:variable name="failed" select="count(testsuite/test[not(contains(result,expected))])"/>

<xsl:template match ='testsuite'>
<html>
     <head>
         <style>
             .good {background-color: #3F0;}
             .bad {background-color:#F30;}
         </style>
 </head>
    <body>
        <h1><xsl:value-of select="@title"/></h1>
            <p><b><xsl:value-of select="round(($success div $total)*100)"/>% Tests ran successfully</b><br/>:<xsl:value-of select="@desc"/></p>

            <table border="1">
             <tr>
                 <td>test name</td>
                 <td>status</td>
                 <td>result</td>
                 <td>expected</td>
             </tr>
            <xsl:apply-templates select="test"/>
        </table>

failed: <xsl:value-of select="$failed"/> /  success: <xsl:value-of select="$success"/> / total: <xsl:value-of select="$total"/>

<hr/>
    <p style="text-align:right"><i><xsl:value-of select="current-dateTime()"/> generated by <a href="http://code.google.com/p/xprocxq">XQuery Unit Test</a>, by jim.fuller@webcomposite.com</i></p>
    </body>
</html>
</xsl:template>

<xsl:template match="test">
    <tr>
        <td><b><xsl:value-of select="name"/></b></td>
        <td>
        <xsl:choose>    
        <xsl:when test="result and expected">
            <xsl:choose>
                <xsl:when test="contains(result,expected)">
                    <div class="good">passed </div>
                </xsl:when>
                <xsl:otherwise>
                    <div class="bad">failed </div>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
             <div>no test</div>
        </xsl:otherwise> 
        </xsl:choose>
        </td>
        <td> <textarea name="content" rows="6" cols="60"><xsl:copy-of select="result/node()"/></textarea></td>
        <td> <textarea name="content" rows="6" cols="60"><xsl:copy-of select="expected/node()"/></textarea></td>
    </tr>
</xsl:template>
</xsl:stylesheet>
