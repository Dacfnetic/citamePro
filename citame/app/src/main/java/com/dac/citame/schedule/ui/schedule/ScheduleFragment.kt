package com.dac.citame.schedule.ui.schedule

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CalendarView
import com.dac.citame.databinding.FragmentProfileBinding
import com.dac.citame.databinding.FragmentScheduleBinding

class ScheduleFragment : Fragment() {

    private var _binding:FragmentScheduleBinding? = null
    private val binding get() = _binding!!

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View {
        // Inflate the layout for this fragment
        _binding = FragmentScheduleBinding.inflate(layoutInflater, container, false)
        return binding.root
    }


}