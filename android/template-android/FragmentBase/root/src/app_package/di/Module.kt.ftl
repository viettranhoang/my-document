package ${packageName}.di

import androidx.fragment.app.Fragment
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.ttee.leeplayer.core.common.ViewModelFactory
import com.ttee.leeplayer.core.di.common.ViewModelKey
import ${packageName}.${fragmentClass}Fragment
import ${packageName}.viewmodel.${fragmentClass}ViewModel
import com.ttee.leeplayer.shared.FeatureScope
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap

/**
 * @author vit
 */
@Module
abstract class ${fragmentClass}Module {

    @Binds
    @FeatureScope
    abstract fun bind${fragmentClass}Fragment(fragment: ${fragmentClass}Fragment): Fragment

    @Binds
    @FeatureScope
    internal abstract fun bindViewModelFactory(viewModelFactory: ViewModelFactory): ViewModelProvider.Factory

    @Binds
    @IntoMap
    @ViewModelKey(${fragmentClass}ViewModel::class)
    abstract fun bind${fragmentClass}ViewModel(viewModel: ${fragmentClass}ViewModel): ViewModel
}