using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Space_Invaders_the_remake
{
    public partial class Form1 : Form
    {
        //Creating the arrats for the pictureboxes.
        //Creates the array for the aliens
        PictureBox[] EnermySquid;
        //Creates an array for the barriers
        PictureBox[] Barriers;

        //set's movement variable
        bool direction = false;

        //Set's the default Alien movement speed
        int MoveAlien = 1;

        //Integer value needed for Scoring
        int Scoring = 0;


        public Form1()
        {
            InitializeComponent();

            //A group of array's being initilised for the amount needed
            //Initialise the aliens and the amount in the array
            this.EnermySquid = new PictureBox[36];
            //Initialise the barriers through the array
            this.Barriers = new PictureBox[8];

            //A list of the pictureboxes used for the aliens.
            //List of the Aliens/Pictureboxes being assigned into the array
            //First row/Squids
            this.EnermySquid[0] = picSquid1;
            this.EnermySquid[1] = picSquid2;
            this.EnermySquid[2] = picSquid3;
            this.EnermySquid[3] = picSquid4;
            this.EnermySquid[4] = picSquid5;
            this.EnermySquid[5] = picSquid6;
            this.EnermySquid[6] = picSquid7;
            this.EnermySquid[7] = picSquid8;
            this.EnermySquid[8] = picSquid9;
            this.EnermySquid[9] = picSquid10;
            this.EnermySquid[10] = picSquid11;
            this.EnermySquid[11] = picSquid12;
            //Second row/Mushrooms
            this.EnermySquid[12] = picMush1;
            this.EnermySquid[13] = picMush2;
            this.EnermySquid[14] = picMush3;
            this.EnermySquid[15] = picMush4;
            this.EnermySquid[16] = picMush5;
            this.EnermySquid[17] = picMush6;
            this.EnermySquid[18] = picMush7;
            this.EnermySquid[19] = picMush8;
            this.EnermySquid[20] = picMush9;
            this.EnermySquid[21] = picMush10;
            this.EnermySquid[22] = picMush11;
            this.EnermySquid[23] = picMush12;
            //Thrid row/Igoglops
            this.EnermySquid[24] = picgog1;
            this.EnermySquid[25] = picgog2;
            this.EnermySquid[26] = picgog3;
            this.EnermySquid[27] = picgog4;
            this.EnermySquid[28] = picgog5;
            this.EnermySquid[29] = picgog6;
            this.EnermySquid[30] = picgog7;
            this.EnermySquid[31] = picgog8;
            this.EnermySquid[32] = picgog9;
            this.EnermySquid[33] = picgog10;
            this.EnermySquid[34] = picgog11;
            this.EnermySquid[35] = picgog12;

            //List for the Barriers array
            this.Barriers[0] = picBar1;
            this.Barriers[1] = picBar2;
            this.Barriers[2] = picBar3;
            this.Barriers[3] = picBar4;
            this.Barriers[4] = picBar5;
            this.Barriers[5] = picBar6;
            this.Barriers[6] = picBar7;
            this.Barriers[7] = picBar8;


        }

        private void btnStart_Click(object sender, EventArgs e)
        {
            //When the Start button is clicked hide all picture and buttons on the home screen
            //Sends the user to the panel used for the game.
            picStart1.Hide();
            picStart2.Hide();
            picStart3.Hide();
            picTitle.Hide();
            btnExit.Hide();
            btnStart.Hide();
            panel1.Show();

        }

        private void btnExit_Click(object sender, EventArgs e)
        {
            //Exit the program when the exit button is pressed by the user
            Application.Exit();
        }

        private void timeComp_Tick(object sender, EventArgs e)
        {


            //Alien movement left and right
            for (int i = 0; i < 36; i++)
            {

                if (this.direction)
                {
                    EnermySquid[i].Left -= MoveAlien;
                    if (EnermySquid[i].Left < 10)
                    {
                        EnermySquid[i].Left = 10;
                        this.direction = false;
                    }
                    //If the aliens touch the players ship a gameover function is used.
                    if (EnermySquid[i].Bounds.IntersectsWith(picShip.Bounds))
                    {
                        Gameover();
                    }      
                }
                else
                    EnermySquid[i].Left += MoveAlien;
                if (EnermySquid[i].Right > this.Width - 10)
                {
                    EnermySquid[i].Left = this.Width - 10 - EnermySquid[i].Width;
                    this.direction = true;
                }

            }


            //Moves the users bullet
            //Only 1 bullet is fired
            if (this.picLaser.Visible)
            {
                this.picLaser.Top -= 7;
                if (this.picLaser.Bottom < 0)
                    this.picLaser.Visible = false;
                else
                    this.CheckBulletCollision(); //Checks for collisions with the function 
            }


        }


        protected override bool ProcessCmdKey(ref Message msg, Keys keyData)
        {
            //Process the key presses off the user
            switch (keyData)
            {
                //User moves left
                case Keys.Left:
                case Keys.A:
                    this.picShip.Left -= 5;
                    if (this.picShip.Left < 10)
                        this.picShip.Left = 10;
                    return true;
                //User moves right
                case Keys.Right:
                case Keys.D:
                    this.picShip.Left += 5;
                    if (this.picShip.Right > this.Width - 10)
                        this.picShip.Left = this.Width - this.picShip.Width - 10;
                    return true;
                //Allows the player to shoot
                case Keys.Space:
                    if (!this.picLaser.Visible)
                    {
                        this.picLaser.Top = this.picShip.Top;
                        this.picLaser.Left = this.picShip.Left + (this.picShip.Width / 2);
                        this.picLaser.Visible = true;
                    }
                    return true;
            }
            return base.ProcessCmdKey(ref msg, keyData);


        }

        private void timUpdate_Tick(object sender, EventArgs e)
        {

        }
        //Function to check for collisions with the enemys and barriers.
        private bool CheckBulletCollision()
        {
            //Checks the collision of the laser with the aliens in thier array
            foreach (PictureBox enermy in this.EnermySquid)
            {
                if ((enermy != null) && (enermy.Visible))
                {
                    if (picLaser.Bounds.IntersectsWith(enermy.Bounds))
                    {
                        enermy.Visible = false;
                        picLaser.Visible = false;
                        Scoring = Scoring + 10;
                        ScoreBoard();
                        return true;
                    }
                    
                }

            }
            //Checks the collisions with the barriers in their array
            foreach (PictureBox barrier in this.Barriers)
            {
                if ((barrier != null) && (barrier.Visible))
                {
                    if (picLaser.Bounds.IntersectsWith(barrier.Bounds))
                    {
                        barrier.Visible = false;
                        picLaser.Visible = false;
                        return true;
                    }
                    

                }

            }

            return false;
        }



        private void timeUpdate_Row_Tick(object sender, EventArgs e)
        {
            //Moves the Aliens down the screen at timed intervals
            for (int i = 0; i < 36; i++)
            {
                //Changing the integer will increase the amount of pixels the aliens drop.
                EnermySquid[i].Top += 3;
            }


        }
        //The function that runs the gameover sequence when active.
        private bool Gameover()
        {
            timeComp.Stop();
            MessageBox.Show("GameOver!");
            return false;

        }
        //A function that aquires the scoring from the alien deaths to be added to a text box.
        private bool ScoreBoard()
        {
            this.txtScore.Text = "";
            txtScore.Text += (Scoring.ToString());
            return false;
        }

        private void picBackground_Click(object sender, EventArgs e)
        {

        }
    }
}
