package com.citame.citame.activities

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.enableEdgeToEdge
import androidx.cardview.widget.CardView
import androidx.core.content.ContextCompat
import androidx.core.graphics.toColor
import com.citame.citame.R

class IMCActivity : ComponentActivity() {

    private lateinit var viewMale: CardView
    private lateinit var viewFemale: CardView

    private var isMaleSelected: Boolean = true
    private var isFemaleSelected: Boolean = false


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_imcactivity)
        initComponents()
        initListeners()
        initUI()
    }

    private fun initUI() {
       setGenderColor()
    }

    private fun changeGender() {
        isMaleSelected = !isMaleSelected
        isFemaleSelected = !isFemaleSelected
    }

    private fun initListeners() {
        viewMale.setOnClickListener {
            changeGender()
            setGenderColor()
        }
        viewFemale.setOnClickListener {
            changeGender()
            setGenderColor()
        }
    }

    private fun setGenderColor() {
        viewMale.setCardBackgroundColor(getBackgroundColor(isMaleSelected))
        viewFemale.setCardBackgroundColor(getBackgroundColor(isFemaleSelected))
    }

    private fun initComponents() {
        viewMale = findViewById(R.id.maleView)
        viewFemale = findViewById(R.id.femaleView)
    }

    private fun getBackgroundColor(isSelectedComponent: Boolean): Int {

        val colorReference = if (isSelectedComponent) {
          R.color.background_component_selected
        } else {
          R.color.background_component
        }
        return ContextCompat.getColor(this, colorReference)
    }
}