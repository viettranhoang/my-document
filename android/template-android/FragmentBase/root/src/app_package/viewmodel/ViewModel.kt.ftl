package ${packageName}.viewmodel

import androidx.lifecycle.LiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.asLiveData
import androidx.lifecycle.viewModelScope
import com.ttee.leeplayer.shared.qualifier.CoDispatcherMainQualifier
import kotlinx.coroutines.CoroutineDispatcher
import javax.inject.Inject

/**
 * @author vit
 */
class ${fragmentClass}ViewModel @Inject constructor(
    @CoDispatcherMainQualifier private val executor: CoroutineDispatcher
) : ViewModel() {

    
}