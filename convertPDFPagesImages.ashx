using System;
using System.Web.SessionState;
using System.Drawing;
using System.Web;
using VarsCore;
using System.IO;
using Cyotek.GhostScript.PdfConversion;
using Common;
using Cyotek.GhostScript;



public class imaging_fmex : IHttpHandler, IRequiresSessionState
{
    public void ProcessRequest(HttpContext context)
    {
        try
        {
            string path = string.Empty;

            Pdf2ImageSettings settings;
            settings = new Pdf2ImageSettings();
            settings.AntiAliasMode = AntiAliasMode.High;
            settings.Dpi = 300;
            settings.GridFitMode = GridFitMode.Topological;
            settings.ImageFormat = ImageFormat.Jpeg;
            settings.TrimMode = PdfTrimMode.CropBox;

            imaging.Details.__PDF_Full_Classified = imaging.Details.__PDFClassified + imaging.Details.__PDFClassified_Folder + imaging.Details.__order_current_File;

            imaging.Details.__PDF_Full_Unclassified = imaging.Details.__PDFUnclassified + imaging.Details.__order_current_File;


            
            string pathPDF = string.Empty;
            
            if (imaging.Details.__PDFClassified_Folder != "")
            {
                pathPDF = imaging.Details.__PDF_Full_Classified;
            }
            else
            {
                pathPDF = imaging.Details.__PDF_Full_Unclassified;
            }
            
            if (File.Exists(pathPDF))
            {
                Pdf2Image CLASS_CONV_IMG = new Pdf2Image(imaging.Details.__PDF_Full_Classified);
                for (int i = 1; i <= CLASS_CONV_IMG.PageCount; i++)
                {
                    path = imaging.Details.__img_TEMP + imaging.Details.__order_current + "-" + i + ".jpg";
                    if (!File.Exists(path))
                    {
                        CLASS_CONV_IMG.ConvertPdfPageToImage(path, i);
                    }
                }
            }
        }
        catch (Exception)
        {
            context.Response.WriteFile("../notFound.png");
        }
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}
