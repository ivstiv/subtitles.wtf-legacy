<template>
    <div class="uploadFile-wrapper" v-cloak @drop.prevent="addFile" @dragover.prevent>
        <input type="file" ref="file" style="display: none" @change="addFile">
        <h1>Upload a movie (drag & drop)</h1>
        <div v-if="!uploadDisabled" class="btn btn__primary" @click="$refs.file.click()">
            <p>Upload</p>
        </div>
        <ul>
            <li v-for="(file, id) in files" v-bind:key="id">
                <div class="chip" @click="removeFile()">
                    <div class="chip__icon">
                        <i class="fas fa-file-video"></i>
                    </div>
                    <p>{{ file.name }}</p>
                    <div class="chip__close">
                        <i class="fas fa-times"></i>
                    </div>
                </div>
            </li>
        </ul>
        <p class="note">
            *You can drag & drop your movie file anywhere on the page.
            *The movie file is not actually uploaded, but processed locally.
        </p>
    </div>
</template>

<script>

export default {
    data() {
        return {
            files:[]
        }
    },

    computed: {
        uploadDisabled() {
            return this.files.length > 0;
        }
    },

    methods:{
        addFile(e) {
            if(this.uploadDisabled) return;

            let droppedFiles;
            if(e.dataTransfer)
                droppedFiles = e.dataTransfer.files;
            else
                droppedFiles = e.target.files;

            if(!droppedFiles) return;
            // this tip, convert FileList to array, credit: https://www.smashingmagazine.com/2018/01/drag-drop-file-uploader-vanilla-js/
            ([...droppedFiles]).forEach(f => {
                this.files.push(f);
            });

            this.getMovieHash();
        },
        removeFile(){
            this.files = [];
            this.$refs.file.value = "";
        },

        async getMovieHash() {
            this.calculateHash(this.files[0])
                .then(hash => {
                    console.log('Movie hash: '+hash);
                });
        },

        calculateHash(file) {
            return new Promise((resolve) => {
                // adapted from this page https://trac.opensubtitles.org/projects/opensubtitles/wiki/HashSourceCodes
                var HASH_CHUNK_SIZE = 65536, //64 * 1024
                longs = [],
                temp = file.size;

                function read(start, end, callback) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        callback.call(reader, process(e.target.result));
                    };

                    if (end === undefined) {
                        reader.readAsBinaryString(file.slice(start));
                    } else {
                        reader.readAsBinaryString(file.slice(start, end));
                    }
                }

                function process(chunk) {
                    for (var i = 0; i < chunk.length; i++) {
                        longs[(i + 8) % 8] += chunk.charCodeAt(i);
                    }
                }

                function binl2hex(a) {
                    var b = 255,
                        d = '0123456789abcdef',
                        e = '',
                        c = 7;

                    a[1] += a[0] >> 8;
                    a[0] = a[0] & b;
                    a[2] += a[1] >> 8;
                    a[1] = a[1] & b;
                    a[3] += a[2] >> 8;
                    a[2] = a[2] & b;
                    a[4] += a[3] >> 8;
                    a[3] = a[3] & b;
                    a[5] += a[4] >> 8;
                    a[4] = a[4] & b;
                    a[6] += a[5] >> 8;
                    a[5] = a[5] & b;
                    a[7] += a[6] >> 8;
                    a[6] = a[6] & b;
                    a[7] = a[7] & b;
                    for (d, e, c; c > -1; c--) {
                        e += d.charAt(a[c] >> 4 & 15) + d.charAt(a[c] & 15);
                    }
                    return e;
                }


                for (var i = 0; i < 8; i++) {
                    longs[i] = temp & 255;
                    temp = temp >> 8;
                }

                read(0, HASH_CHUNK_SIZE, function() {
                    read(file.size - HASH_CHUNK_SIZE, undefined, function() {
                        resolve(binl2hex(longs));
                    });
                });
            });
        }
    }
}
</script>

<style lang="scss" scoped>
@import '../styles/components/UploadFile.scss';
</style>