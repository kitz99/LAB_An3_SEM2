using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Metoda_Rotatiilor
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        /// 
        public class valori_proprii : Metoda
        {
            private int p, q, n;
            private decimal[,] x = new decimal[8,8];
            private decimal[,] y = new decimal[8,8];
            private decimal[,] qq = new decimal[8, 8];
            private decimal[,] rr = new decimal[8, 8];
            private decimal[] z = new decimal[8];
            private decimal[] zz = new decimal[8];
            private decimal[] w = new decimal[8];
            private decimal[] ww = new decimal[8];
            private decimal[] xx = new decimal[8];
            private decimal max, theta, c, s, modul;
            public override void rotatii()
            {
                for (int i = 0; i < m; i++)
                    for (int j = 0; j < m; j++) x[i, j] = a[i, j];
                n = 0;
                do
                {
                    n++;
                    max = 0;
                    for (int i = 0; i < m; i++)
                        for (int j = i + 1; j < m; j++)
                            if (max < Math.Abs(x[i, j]))
                            {
                                p = i; q = j;
                                max = Math.Abs(x[i, j]);
                            }
                    if (x[p, p] == x[q, q]) theta = (decimal)Math.PI / 4;
                    else theta = 0.5m * (decimal)Math.Atan((double)(2m * x[p, q] / (x[p, p] - x[q, q])));
                    c = (decimal)Math.Cos((double)theta); s = (decimal)Math.Sin((double)theta);
                    for (int i = 0; i < m; i++)
                        for (int j = 0; j < m; j++) y[i, j] = x[i, j];
                    for (int j = 0; j < m; j++)
                        if ((j != p) && (j != q))
                        {
                            y[p, j] = y[j, p] = c * x[p, j] + s * x[q, j];
                            y[q, j] = y[j, q] = -s * x[p, j] + c * x[q, j];
                        }
                    y[p, p] = c * c * x[p, p] + 2 * c * s * x[p, q] + s * s * x[q, q];
                    y[q, q] = s * s * x[p, p] - 2 * c * s * x[p, q] + c * c * x[q, q];
                    y[p, q] = y[q, p] = 0.0m;
                    for (int i = 0; i < m; i++)
                        for (int j = 0; j < m; j++) x[i, j] = y[i, j];
                    modul = 0.0m;
                    for (int i = 0; i < m; i++)
                        for (int j = 0; j < m; j++)
                            if (i != j) modul += x[i, j] * x[i, j];
                    modul=(decimal)Math.Sqrt((double)modul);
                    asteapta(1);
                    afiseaza();
                    afiseaza_matricea(x);
                    textBox_itr.Text = n.ToString();
                    textBox_eroare.Text = modul.ToString();
                    if (m >= 2)
                    {
                        textBox_l1.Text = x[0, 0].ToString();
                        textBox_l2.Text = x[1, 1].ToString();
                    }
                    if (m >= 3) textBox_l3.Text = x[2, 2].ToString();
                    if (m >= 4) textBox_l4.Text = x[3, 3].ToString();
                    if (m >= 5) textBox_l5.Text = x[4, 4].ToString();
                    if (m >= 6) textBox_l6.Text = x[5, 5].ToString();
                    if (m >= 7) textBox_l7.Text = x[6, 6].ToString();
                    if (m >= 8) textBox_l8.Text = x[7, 7].ToString();
                    asteapta(1);
                }
                while (modul > eps);


            }

            
            }
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new valori_proprii());
        }
    }
}