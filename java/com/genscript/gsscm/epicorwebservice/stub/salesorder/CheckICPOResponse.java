
package com.genscript.gsscm.epicorwebservice.stub.salesorder;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="CheckICPOResult" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="icpoFound" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="callContextOut" type="{http://epicor.com/schemas}CallContextDataSetType" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "checkICPOResult",
    "icpoFound",
    "callContextOut"
})
@XmlRootElement(name = "CheckICPOResponse")
public class CheckICPOResponse {

    @XmlElement(name = "CheckICPOResult", namespace = "http://epicor.com/webservices/")
    protected boolean checkICPOResult;
    @XmlElement(namespace = "http://epicor.com/webservices/")
    protected boolean icpoFound;
    @XmlElement(namespace = "http://epicor.com/webservices/")
    protected CallContextDataSetType callContextOut;

    /**
     * Gets the value of the checkICPOResult property.
     * 
     */
    public boolean isCheckICPOResult() {
        return checkICPOResult;
    }

    /**
     * Sets the value of the checkICPOResult property.
     * 
     */
    public void setCheckICPOResult(boolean value) {
        this.checkICPOResult = value;
    }

    /**
     * Gets the value of the icpoFound property.
     * 
     */
    public boolean isIcpoFound() {
        return icpoFound;
    }

    /**
     * Sets the value of the icpoFound property.
     * 
     */
    public void setIcpoFound(boolean value) {
        this.icpoFound = value;
    }

    /**
     * Gets the value of the callContextOut property.
     * 
     * @return
     *     possible object is
     *     {@link CallContextDataSetType }
     *     
     */
    public CallContextDataSetType getCallContextOut() {
        return callContextOut;
    }

    /**
     * Sets the value of the callContextOut property.
     * 
     * @param value
     *     allowed object is
     *     {@link CallContextDataSetType }
     *     
     */
    public void setCallContextOut(CallContextDataSetType value) {
        this.callContextOut = value;
    }

}
