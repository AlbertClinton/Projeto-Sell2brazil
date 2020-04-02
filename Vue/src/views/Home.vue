<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png" />
    <h1></h1>
    <div class="row d-flex justify-content-center">
      <div class="col-3">
        <label for="name">Nome</label>
        <input class="form-control" type="text" id="name" v-model="form.name" />
        <label class="small text-danger" for="name" v-if="erros.name">{{erros.name[0]}}</label>
      </div>
      <div class="col-3">
        <label for="email">Email</label>
        <input class="form-control" type="text" id="email" v-model="form.email" />
        <label class="small text-danger" for="email" v-if="erros.email">{{erros.email[0]}}</label>
      </div>
      <div class="col-3">
        <label for="cpf">CPF</label>
        <input class="form-control" type="text" id="cpf" v-model="form.cpf" />
        <label class="small text-danger" for="cpf" v-if="erros.cpf">{{erros.cpf[0]}}</label>
      </div>
    </div>
    <br />
    <div class="row d-flex justify-content-center">
      <div class="col-3">
        <label for="password">Senha</label>
        <input class="form-control" type="password" id="password" v-model="form.password" />
        <label class="small text-danger" for="password" v-if="erros.password">{{erros.password[0]}}</label>
      </div>
      <div class="col-3">
        <label for="password_confirmation">Confirmar Senha</label>
        <input
          class="form-control"
          type="password"
          id="password_confirmation"
          v-model="form.password_confirmation"
        />
      </div>
    </div>
    <br />
    <div class="row d-flex justify-content-center">
      <button class="form-control col-1" @click="createUser()">Adicionar</button>
    </div>
    <br />
    <div class="table-resposive row d-flex justify-content-center">
      <table class="table col-9">
        <thead>
          <tr>
            <th>Nome</th>
            <th>CPF</th>
            <th>Email</th>
            <th colspan="2">Ações</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(user, index) in usuarios">
            <td>
              <input
                :id="user.id+'name'"
                :class="'form-control input'+user.id"
                type="text"
                :disabled="editing != user.id"
                v-model="user.name"
                @blur="updateUser(user)"
              />
              <label
                class="small text-danger"
                :for="user.id+'name'"
                v-if="editing == user.id && editingErrors.name"
              >{{editingErrors.name[0]}}</label>
            </td>
            <td>
              <input
                :id="user.id+'cpf'"
                :class="'form-control input'+user.id"
                type="text"
                :disabled="editing != user.id"
                v-model="user.cpf"
                @blur="updateUser(user)"
              />
              <label
                class="small text-danger"
                :for="user.id+'cpf'"
                v-if="editing == user.id && editingErrors.cpf"
              >{{editingErrors.cpf[0]}}</label>
            </td>

            <td>
              <input
                :id="'email'+user.id"
                :class="'form-control input'+user.id"
                type="text"
                :disabled="editing != user.id"
                v-model="user.email"
                @blur="updateUser(user)"
              />
              <label
                class="small text-danger"
                :for="'email'+user.id"
                v-if="editing == user.id && editingErrors.email"
              >{{editingErrors.email[0]}}</label>
            </td>
            <td>
              <button
                class="form-control"
                v-if="editing != user.id"
                :id="'btn'+user.id"
                @click="editing = user.id"
              >Editar</button>
              <button
                class="form-control"
                v-if="editing == user.id"
                :id="'btn'+user.id"
                @click="updateUser(user)"
              >Salvar</button>
            </td>
            <td>
              <button class="form-control" @click="deleteUser(user)">Excluir</button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
    <!-- <HelloWorld msg="Welcome to Your Vue.js App" /> -->
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from "@/components/HelloWorld.vue";
import axios from "axios";

export default {
  name: "Home",
  components: {
    HelloWorld
  },
  data() {
    return {
      URL: "http://localhost:8000/api",

      form: {},
      erros: "",
      usuarios: [],
      editing: "",
      editingErrors: ""
    };
  },
  mounted() {
    this.getUsers();
  },
  methods: {
    getUsers() {
      axios.get(this.URL + "/user").then(response => {
        this.usuarios = response.data;
      });
    },
    createUser() {
      axios.post(this.URL + "/user", this.form).then(response => {
        let res = response.data;
        console.log(response);
        if (res.id) {
          alert("Usuario criado com sucesso!");
          this.form = {};
          this.getUsers();
        } else {
          this.erros = res;
        }
      });
    },

    updateUser(user) {
      console.log(user);
      axios.put(this.URL + "/user/" + user.id, user).then(response => {
        let res = response.data;
        if (res.id) {
          this.editing = "";
          // alert("Usuario atualizado com sucesso!");
          // this.getUsers();
        } else {
          this.editingErrors = res;
        }
      });
    },

    deleteUser(user) {
      axios.delete(this.URL + "/user/" + user.id).then(response => {
        if (response) {
          alert("Usuario deleteado com sucesso!");
          this.getUsers();
        }
      });
    }
  }
};
</script>
