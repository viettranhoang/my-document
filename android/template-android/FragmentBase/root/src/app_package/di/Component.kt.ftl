package ${packageName}.di

import com.ttee.leeplayer.core.di.CoreComponent
import com.ttee.leeplayer.core.di.coreComponent
import com.ttee.leeplayer.core.di.module.SharedPreferencesModule
import com.ttee.leeplayer.dashboard.data.di.DashboardDataModule
import com.ttee.leeplayer.dashboard.data.repository.source.cache.DashboardCache
import ${packageName}.${fragmentClass}Fragment
import com.ttee.leeplayer.shared.FeatureScope
import dagger.BindsInstance
import dagger.Component
import dagger.android.AndroidInjector

/**
 * @author vit
 */
@FeatureScope
@Component(
    modules = [${fragmentClass}Module::class, DashboardDataModule::class, SharedPreferencesModule::class],
    dependencies = [CoreComponent::class]
)
interface ${fragmentClass}Component : AndroidInjector<${fragmentClass}Fragment> {

    @Component.Factory
    interface Factory {
        fun create(
            coreComponent: CoreComponent,
            module: SharedPreferencesModule,
            @BindsInstance fragment: ${fragmentClass}Fragment
        ): ${fragmentClass}Component
    }
}

fun ${fragmentClass}Fragment.inject() {
    Dagger${fragmentClass}Component
        .factory()
        .create(
            coreComponent(),
            SharedPreferencesModule(requireContext(), DashboardCache.DASH_BOARD_PREF),
            this
        )
        .inject(this)
}