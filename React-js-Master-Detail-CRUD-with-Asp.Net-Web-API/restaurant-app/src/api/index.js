import axios from "axios";

const BASE_URL = 'http://localhost:5000/api/';

export const ENDPIONTS = {
    CUSTOMER: 'Customer',
    FOODITEM: 'FoodItem',
    ORDER: 'Order'
}

const instance = axios.create({
    baseURL: BASE_URL,
    // timeout: 10000,
  });

export const createAPIEndpoint = endpoint => {

    let url = BASE_URL + endpoint + '/';
    return {
        fetchAll: () => instance.get(url),
        fetchById: id => instance.get(url + id),
        create: newRecord => instance.post(url, newRecord),
        update: (id, updatedRecord) => instance.put(url + id, updatedRecord),
        delete: id => instance.delete(url + id)
    }
}