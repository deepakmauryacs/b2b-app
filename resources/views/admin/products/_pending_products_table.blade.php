<tbody>
    @forelse($products as $product)
        <tr>
            <td>{{ $loop->iteration + ($products->currentPage() - 1) * $products->perPage() }}</td>
            <td>{{ $product->product_name }}</td>
            <td>{{ $product->vendor->name ?? 'N/A' }}</td>
            <td>{{ $product->category->name ?? 'N/A' }}</td>
            <td>₹{{ number_format($product->price, 2) }}</td>
            <td>{{ $product->stock_quantity }}</td>
            <td>{{ $product->updated_at->format('d-m-Y') }}</td>
            <td>
                <div class="d-flex gap-2">
                    <!-- View -->
                    <a href="{{ route('admin.products.approved.show', $product->id) }}"
                       class="btn btn-sm btn-soft-info"
                       title="View">
                        <i class="bi bi-eye"></i>
                    </a>

                    <!-- Approve -->
                    <button type="button"
                            class="btn btn-sm btn-success btn-approve"
                            data-id="{{ $product->id }}"
                            data-name="{{ $product->product_name }}"
                            title="Approve">
                        <i class="bi bi-check2-circle"></i>
                    </button>

                    <!-- Reject -->
                    <button type="button"
                            class="btn btn-sm btn-outline-danger btn-reject"
                            data-id="{{ $product->id }}"
                            data-name="{{ $product->product_name }}"
                            title="Reject">
                        <i class="bi bi-x-circle"></i>
                    </button>
                </div>
            </td>
        </tr>
    @empty
        <tr>
            <td colspan="8" class="text-center">No pending products found.</td>
        </tr>
    @endforelse
</tbody>
<tfoot>
    <tr>
        <!-- Pass the $products paginator to the custom pagination component -->
        <x-custom-pagination :paginator="$products" />
    </tr>
</tfoot>