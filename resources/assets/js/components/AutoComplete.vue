<template>
    <div style="position:relative">
        <input class="form-control" type="text" :value="value" @input="updateValue($event.target.value)"
          @keydown.enter = 'enter'
          @keydown.down = 'down'
          @keydown.up = 'up'
          data-toggle="dropdown"
          required="" 
        >
        <div class="dropdown-menu" style="width:100%"  v-bind:class="{'open show':openSuggestion}">
            <a class="dropdown-item" v-for="(suggestion, index) in matches"
                v-bind:class="{'active': isActive(index)}"
                @click="suggestionClick(index)"
            >
              {{ suggestion.name }} 
              
            </a>
        </div>
    </div>
</template>
<script>
	export default {

    props: {

	    value: {
	      type: String,
	      required: true
	    },

	    suggestions: {
	      type: Array,
	      required: true
	    }

	 },

    data () {
	  return {
	    open: false,
	    current: 0
	  }
	},

	computed: {

	    matches () {
	     return this.suggestions.filter((obj) => {
	       return obj.name.indexOf(this.value) >= 0
	     })
	   	},

	   	openSuggestion () {
	     return this.selection !== '' &&
	            this.matches.length !== 0 &&
	            this.open === true
	  	 }
	},

	methods: {
	    updateValue (value) {
		    if (this.open === false) {
		      this.open = true
		      this.current = 0
		    }
		    this.$emit('input', value)
		  },

		  enter () {
		    this.$emit('input', this.matches[this.current].name)
		    this.$emit('selected', this.matches[index])
		    this.open = false
		  },

		  up () {
		    if (this.current > 0) {
		      this.current--
		    }
		  },

		  down () {
		    if (this.current < this.matches.length - 1) {
		      this.current++
		    }
		  },

		  isActive (index) {
		    return index === this.current
		  },

		  suggestionClick (index) {
		    this.$emit('input', this.matches[index].name)
		    this.$emit('selected', this.matches[index])
		    this.open = false
		  }
	}
}
</script>