using AccessModel;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UserInterface
{
    public partial class Operations : Form
    {
        public Operations()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //TODO we override OnFormClosing, so no need to savechanges here
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Enabled = false;
            (new RegisterOperation()).Show();
            this.Focus();
            this.Enabled = true;
        }

        protected override void OnFormClosing(FormClosingEventArgs e)
        {
            base.OnFormClosing(e);
            DBManager.getSingleton().Close();
        }

        private void button7_Click(object sender, EventArgs e)
        {
            this.Enabled = false;
            (new AddEmployee()).Show();
            this.Focus();
            this.Enabled = true;
        }
    }
}
