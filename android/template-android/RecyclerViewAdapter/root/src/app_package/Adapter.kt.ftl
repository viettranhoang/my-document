package ${packageName}

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.extensions.LayoutContainer
import kotlinx.android.synthetic.main.${layoutItem}.*

class ${adapterClass}Adapter : RecyclerView.Adapter<${adapterClass}Adapter.${adapterClass}ViewHolder>() {

    var list: List<${modelClass}> = listOf()
        set(value) {
            field = value
            notifyDataSetChanged()
        }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ${adapterClass}ViewHolder {
        val view = LayoutInflater.from(parent.context).inflate(R.layout.${layoutItem}, parent, false)
        return ${adapterClass}ViewHolder(view)
    }

    override fun getItemCount(): Int = list.size

    override fun onBindViewHolder(holder: ${adapterClass}ViewHolder, position: Int) {
        holder.bindData(list[position])
    }

    inner class ${adapterClass}ViewHolder(override val containerView: View) :
        RecyclerView.ViewHolder(containerView), LayoutContainer {

        fun bindData(item: ${modelClass}) {
            when (item) {
                
            }
        }
    }
}