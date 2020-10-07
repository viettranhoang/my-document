package ${packageName}

import android.content.Context
import android.os.Bundle
import android.view.View
import androidx.fragment.app.viewModels
import androidx.lifecycle.ViewModelProvider
import com.ttee.leeplayer.core.base.fragment.BaseBindingFragment
import ${packageName}.viewmodel.${fragmentClass}ViewModel
import ${packageName}.di.inject
import javax.inject.Inject

/**
 * @author vit
 */
class ${fragmentClass}Fragment : BaseBindingFragment<${fragmentClass}FragmentBinding>(
    layoutId = R.layout.${layout}
) {

    @Inject
    lateinit var viewModelFactory: ViewModelProvider.Factory

    private val viewModel by viewModels<${fragmentClass}ViewModel> { viewModelFactory }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        inject()
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        with(binding) {
            viewModel = this@${fragmentClass}Fragment.viewModel

        }
		
		onViewModel()
    }
	
	private fun onViewModel() {
	
	}
}