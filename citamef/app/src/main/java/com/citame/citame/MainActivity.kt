package com.citame.citame

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.activity.ComponentActivity
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.AppCompatButton
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.citame.citame.activities.IMCActivity
import com.citame.citame.activities.Placeholder
import com.citame.citame.activities.SignInActivity
import com.citame.citame.ui.theme.CitameTheme

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_main)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val toSignInActivity = findViewById<Button>(R.id.toSignInActivity)
        toSignInActivity.setOnClickListener{
            changeActivity(1)
        }

        val toIMCActivity = findViewById<Button>(R.id.toIMCActivity)
        toIMCActivity.setOnClickListener{
            changeActivity(2)
        }

    }

    private fun changeActivity(clase: Int){
        if(clase == 1){
            val intent = Intent(this, SignInActivity::class.java)
            startActivity(intent)
        }
       if(clase == 2){
            val intent = Intent(this, IMCActivity::class.java)
            startActivity(intent)
       }

    }
}