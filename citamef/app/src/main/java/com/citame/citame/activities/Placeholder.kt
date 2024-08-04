package com.citame.citame.activities

import android.os.Bundle
import android.widget.TextView
import androidx.activity.ComponentActivity
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.citame.citame.R

class Placeholder : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_placeholder)
        val texto = findViewById<TextView>(R.id.texto)
        val name:String = intent.extras?.getString("prueba").orEmpty()
        texto.text = name
    }
}