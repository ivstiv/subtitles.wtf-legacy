<template>
	<div id="app">
		<!--
		<img alt="Vue logo" src="./assets/logo.png">
		<HelloWorld msg="Welcome to Your Vue.js App"/>
		-->
		<div class="logo">
			<img src="./assets/logo2.png" alt="logo">
		</div>
		<div class="searching-wrapper">
			<SearchTitle></SearchTitle>
			<h1 class="or">OR</h1>
			<upload-file></upload-file>
		</div>
	</div>
</template>

<script>
//import HelloWorld from './components/HelloWorld.vue'
import SearchTitle from './components/TitleSearch.vue'
//import LanguageSearch from './components/LanguageSearch.vue'
import UploadFile from './components/UploadFile.vue'

export default {
	name: "App",
	components: {
		SearchTitle,
		//LanguageSearch,
		UploadFile
		// HelloWorld
	}
};
</script>

<style lang="scss">
@import 'styles/global.scss';

.logo {
	width: 50rem;
	border-radius: 3rem;
	box-shadow: 0.8rem 0.8rem 1.4rem var(--greyLight-2),
				-0.2rem -0.2rem 1.8rem var(--white);
	padding: 2rem;
	margin: 0 auto;
	margin-top: 1rem;
	cursor: pointer;

	@media (max-width: 560px) {
		width: 35rem;
	}

	img {
		max-width: 100%;
		height: auto;
		box-shadow: $shadow;
		padding: 5rem;
		margin: 0 auto;
		border-radius: 3rem;
	}

	&:active img {
		box-shadow: $inner-shadow;
	}
}

.or {
	font-size: 5rem;
	@media (max-width: 1124px) {
		width: 100%;
		text-align: center;
    }
}

.searching-wrapper {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
	justify-content: space-evenly;
	margin-top: 3rem;
}

</style>