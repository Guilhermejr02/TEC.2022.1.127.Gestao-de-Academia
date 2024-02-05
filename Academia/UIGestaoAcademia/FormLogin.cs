﻿using BLL;
using DAL;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Reflection.Emit;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace UIGestaoAcademia
{
    public partial class FormLogin : Form
    {
        public bool Logou;

        public FormLogin()
        {
            InitializeComponent();
            Logou = false;

        }

        private void buttonEntrar_Click(object sender, EventArgs e)
        {
                      
            try
            {
                new UsuarioBLL().Altenticar(textBoxUsuario.Text, textBoxSenha.Text);
                Logou = true;
                Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }

        private void FormLogin_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Escape)
                Close();
        }

        private void textBoxUsuario_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
                textBoxSenha.Focus();
        }

        private void textBoxSenha_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
                buttonEntrar_Click(null, null);
        }

        private void FormLogin_Load(object sender, EventArgs e)
        {
            label1.Parent = pictureBox2;
            label2.Parent = pictureBox2;
            label1.BackColor = Color.Transparent;
            label2.BackColor = Color.Transparent;

            if (File.Exists(Environment.CurrentDirectory + "\\Imagens\\fundologin.png"))
                pictureBox2.ImageLocation = Environment.CurrentDirectory + "\\Imagens\\fundologin.png";
        }
    }
}
